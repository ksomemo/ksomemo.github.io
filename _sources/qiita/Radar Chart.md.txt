## 動機
- Rでのクラスタリング結果をレーダーチャートで表示する例をPythonでもやってみたかった
- めんどうであることがわかった

## references
- http://matplotlib.org/examples/api/radar_chart.html
    - matplotlibのexample
- http://sinhrks.hatenablog.com/entry/2015/11/15/222543
    - pandas datasetでの簡単radar chart
- http://blog.kzfmix.com/entry/1216719888
    - exampleと似たもの
    - pylab full import使ってるので試すときはpyplotとnumpyでカバー

## keywords
- projection
    - matplotlib.projections
    - register_projection
- polar
    - PolarAxes

### axの拡張
- projectionを指定して用意されている軸を使用することが出来る
    - 参考2はこれ
    - 極座標変換をしているらしい
    - polarが極を意味する
- 用意されているものでは外周が円のまま
    - 本家では用意されているpolarを拡張している
    - レーダーチャートの角になる

```dummy.txt
.
```
