Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795425547;
	b=T7Ozcmy9cSUh1TybEBQu1K2JoHyvXgIFK7WUS0Cc4vrdfr1+t8eDXLU0A0axnvlZ6EuH
	 ek8HUMPawRCBRY62jzHx4LRWRO8wR4AFmSb74urKPK/Vpc5U3RYJUBh1GiHtw2EC/8tUi
	 vrs/RaNu8oUh+r//tIIWVccan9ORpxF3fEDENpx8LhK5sXctBT0VaUe8lRLW1Pgj9LOcY
	 9zFcOUKNYnb07n77bJ8Mo5+x3V55/uLSu/4BVBTR0ulkLa16KWLWaKYGk1qS2+meV7qQA
	 SlCB/1ajeX6B5CQNEbjsr09ItPElsH/Wh9/xUmifj/tvUpsCpipJkAn/exTE4OMdMsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425547;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=mzB0NWSl1HLNOAjsoEm294uEcIifYegq5gL/jiWW8WM=;
	b=ocVzBrhhu87uAFEnt8swT/6l2wthK1njY+JKPp7eTmZnexVGNL+UIyTHR56mjxPPSbwt
	 7ZkUFPrjhRWEuR9Cw/rJ+EYSzL5JeMGr+Cmix2UO/u6abZ3z/QhxJ/iuPzI2YEsN1q0kJ
	 LSBs/9PAntWrCbJUys/V0y9Kmf/fQ8/l+0+HKyebgNXSRDkTjZO1pTgjZHOXixmeCrZOq
	 4NlsdYx1GkEYbWd7q7zXoxPjAGJOil19BilayJvRpGtlDJlXQMBRR1NE66ZK74l0jE1l3
	 TeRBgMvGigzM059dhN5Fi/jKLA+hBcjTncekeU8FxKddOOttJ+o/JdggrV5AeeqC/2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=10jens@web.de header.a=rsa-sha256 header.s=s29768273 header.b=dr7JYFgX;
	arc=none smtp.remote-ip=212.227.15.3
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D856F606A31F
	for <kvm@vger.kernel.org>; Mon, 23 Nov 2026 09:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D856F606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=10jens@web.de header.a=rsa-sha256 header.s=s29768273 header.b=dr7JYFgX
DKIM2-Signature:  i=1; m=1; t=1795425539;
 mf=PDEwamVuc0B3ZWIuZGU+;
 rt=PGt2bUB2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:rmz9puMjPjQZNMdueBR59ziBTrA6
   PeIfWaGqAJhBn90/8BQFAiAz7GjpnNgFOymht30rjRbb5QOSIfhdyw0lymNZHHprALjt7A9ee3J
   brbvBlhz+tiBspNVn7RI+y5Xc5x89f418bLW3yecXkWPaAfkuhnKYfX8cRernWfDWsHOf4rhzqA
   5sZbFLhdh6OtHyawnPUwysJQ/q5TEqW/YJfykcxKch9UarB2bHEuH2On2+s9q+nYFA6H5v7hbZe
   wNA7a4myVuuiLF+7EFBWPy3bT7ak6UOeozoF8/Fgj8u8dq0Hbe4HoFrN/WtIIbiHdTfiK3KBPsq
   hMOO8cCORGnNBg==;
Message-Instance:  m=1;
 h=sha256:
   lSfhI5GoMgjuLm9nstI/ntufGUjEp61fMOaOF3ZSGGM=:
   mzB0NWSl1HLNOAjsoEm294uEcIifYegq5gL/jiWW8WM=,
  sha512:
   qc7xyfK1TxzJezoVdVitg20st7H8SbhfTjcGRilcgn4aghALfeRJsJA0gKerOgXAP/ygBFOXqBMfE4wnzHslfw==:
   4ZT5c2/7EK94OmL8njIFkn2uZJ09mJWSi9v26FtpQOJvglmzVYrNSGOVTL8h/7A25zbrnQmdXdAUMMiYYrK8NA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795425539; x=1796030339; i=10jens@web.de;
	bh=mzB0NWSl1HLNOAjsoEm294uEcIifYegq5gL/jiWW8WM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dr7JYFgXWcVOjJapYF7P1DZy2eKZlh8HvWFLKrX/hfnkqlVjWjKuMGcpAFOcMt77
	 HDaG5ElY4V7KDPteuJip9tV37j4JYhZjRRyljZG/k1NawEGr5yN5LpKxq3D7tZcEV
	 mywSOV7rm0IZJUuX/8j5IyPJHqif8jc3sptCDqBqPJoCrCOGhNN9IqY887EOKDRjE
	 gn1SmDS7EV0Skn3/EY4S85r7QpuZe3pPqjyheSzFtxpvfqXf7tCP/0SkZx60LDEme
	 RX3Lr3bjQxUh8GKU5yrlteYrnZeMtvktc3991eDsB3l1TLquZcs9rjAAUljBaxwqz
	 Uj8DpQ9F7J0bJyhBtw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M7ept-1xbDV13SFZ-0091Wu; Mon, 23
 Nov 2026 10:18:58 +0100
Message-ID: <24b3eb09-e9e1-493e-9b9a-4f7a8090aeb7@web.de>
Date: Mon, 23 Nov 2026 10:18:58 +0100
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug Report Linux kvm/qemu: Frequent Boot Issues with Windows 11
 ARM64 VMs on NVIDIA DGX Spark due to Potential KVM PMU Migration Issues
From: Jens Neubert <10jens@web.de>
To: kvm@vger.kernel.org
Cc: maz@kernel.org, pbonzini@redhat.com
References: <af150d64-feff-4ef0-905a-14ab55b074fa@web.de>
Content-Language: en-US
In-Reply-To: <af150d64-feff-4ef0-905a-14ab55b074fa@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wReI0DnC3VZx8wluwiVImDGN6ILXAPqUme4nhepVp5R1YySSr0f
 R3uJCzz1OG0c/tAYAeSpWQmhOVhuwq5Bev1wmJZku+MkBopThmoEZl/Yl8icQGiCGyKz8pf
 vRGXKO0cIwnfPfa5vEwndgCVyv4medkccypnSNDcHYOt9ohoBlNcZ8N2OxqIg91ME8YaKFf
 xqcKEE7/aqm6lQnTHazPw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VzFOU3S5C5o=;fyOWmmWePtnA4xnOap0/cW2Nqah
 lFk+FFFgx3tk0zisAtrO4U7v02JRS0EYv/rEEoqcO1cNoZzFgWdLiasbr1KGn3w13XNRMO8GC
 eUFAMTp3ak8nzPxXhtcayb1TyYlqx1/QevRRNfVcEzleGBd170o0gbMSV2gSNXNJ7KVFi1cSv
 asDSfRvgOTGXno4AO0XdYYDBlfgkO3Llo6XKqxvAYS21uxX4b8g4YIdRhhHeWnCHCkGhWZYVL
 AUFyhQ8c5iN8BG1Js8L/UQ97N6DQADdiPYuflSqTABRtikIUsOm7jHAlG0DLWCCq93dQPG00c
 xGdVEdEvh+7WNGNrFHu2n/iNlDpstGLpBsOa1J6IM4Vss4tzqlck8avELwsT1Acupsj9ALGA+
 Y5gNyRX8UXErEUmZU7bUG6BSjbXcnpnLR0hz8uW4slKxSTT9VwWB7nq8uvcsN8V3i+0rzJnnp
 a5B+1NxX1U+ldDKQKfZlUWEjD3Rs4WPzlHHVY+DjvxpjC387ZhaI7RyN/zMxefy+I8kEy0njc
 pRem5DEthhTn/G1lEHU5SB6VdwKi5lK5SeGF+H1upgB8PSvy3H9ugfXJU1VaxAbb2sGRfjdSf
 E8YsJc9GOaR6tiOr3kaTkw9/OgrPRgeeqaByM6k8nnThvcEwEiPOiXeludKBJ9D7KXNnKHs24
 nfBZfkTLDpwmqqZZbVy+e5CNM3bAS7uYIAG6mwEZSqsnCvGToVnvODjX66/D9QjNKWB7AJ1/r
 g4yLdUo6EN2v9CbjzXoqqC+vNQDldRbFmCk+DjgTass/+TO1pjaBA5Z0JBgkZGvpE27f8R+0Y
 FeQ5D+AhKWg2cz74kgAPDbwcx9doz3Jazk2mFKdcO9OVWwc5LFoOJawQAkftartOmmLGZk5Y9
 s37iPwukCjIBXFOtvCqnhJ55AF17lufxrh76rvzZLCr3hv6cWFYkoZE24EoflaF/nbIgMlCdY
 lHBVS2yIBlE591mzv3BB7bFNIA7v0ek+JQWljDR78mQOcIN9ozK9I04N+5E050EMIf8cReiIP
 XO09lEsZGR1JPk1eVkHmBOtr11cOgXIEx1c8qCjh7vgulrCL3Li8deLkdu9fLz4k9xr1MsON5
 kQDRnQuwr/45xGlo029/QMC7/gmKOvUd/16E5/jorEb7DX0GJ/Xnn9xq/IuqGsSqpgG/US6h3
 MfbaH3y6sB77ndu1rj8dMjSzdonsBUEDmd90M+GX1FUTIn33Cy8CRWq56CpaYfDce+nfOIvY2
 DZk5WNf4ugUlhUmu+hpznOO8ZyAwBzb1i4Q7wobAj5RF5XI2D3HzxZCbBDX2beJ2Jj0TeToI6
 41KAe89rO4EaeCQgofvf4MmXUOs8JhkV75AHkBdGT4t+s8AbJdZHOSA1+cN4xTnfgCOVs+Fju
 z/Ej0+Zbm4u+UwGwWMueHHXapI4N0K9828lW9GPNNmMUJynJQHHap5mpayo3iRU9jqbuWipl0
 nG/3IUYdWcR/+0xo/pOuEfW+rCKAEen5Uy+JIQMEG5ZNmnIZ9tEgAROkToC1GcfNiNImwebS2
 9RqGeHUK58bYYUmI90lwIsKKpqY2ECkPXWQ1KxYHQanBmWn9wb19joERhhtbYnVTXQX1p33o+
 rfz/D5nQyuAx+4dfOYdrKsF+zibhsqXfODK+H3v+U1w/3TeWE4+F7COttPH3t5Go19NUpGwjV
 Fy3yG3YZ6HE0N4G4oQlYDtSfAXnRDB0/4ZVpN6zdqqi3qwj2qSWPJh4wprOxEuaYGdLfecPW+
 wsGmkRO1fYTvgPbmZwcBLm4DIhHxagge0rql7LyssIPyhDC3vgHoVTD8oq99IVFfHswrg/BDN
 oNY/dxiWpLfNc61vllqWyttcxs52Ds0Ib2RfKQbD44oq4YnvLVOx524Z0VZdW0Ih0IiSjrVnU
 DUM5qDBA+APM4uXEhbZTMeE9Y+hfmK1QM7NuypZ11NETJqvjkEn2XQ4NjlH5W9BJCwHxWR40s
 nTiX/S6UV3odS94W+WJctQBarJGQ2FY9qTq2viXzq5WUN0YnE1DKPoH3q//KdQWvURTmh+MLB
 ISWjaKHMM8fplC73R0e7IK+88rBUisskFzyrsjcKtb1M/WAC0r5TTyZgLacjA5lItOy9oI43i
 nNGfPBWJRVi3Iq6QBEepsz38TomK+IxLCjoWhPhfb+GkVa7szk9BmfzBAGekf5XKY6eGJYm+M
 YZZCnwqZoUWNS3Rn0fg1frYM9eSpCCD56d8/N1GvOZeV34HU82vrm21H0uC3HtGGnKUAKN6C+
 XpdfWNrbOLYXo1kbYy1Xfmoxj4ZQr8y23apwIX4x/bugbPSaebrCtAKoH/kxHAcQHl3nOYnhJ
 pvYq7TU69TZEFMFAfSlrnaF0Bdhesxr/yDr5dVw23kuWLeqnmYlS3Vu+sKbvM4SkH0Mo0Rry8
 Y4N4keHsCIT20D5rVgD0Z5w+pJBNvVEj9Nv3p8VHKKiyaNvkW9BFiSZvVfkdR0kSJheQHk3Xp
 OqfgKob+1BL++Kd06WCxibmlDPMxL5hWKur8F7oIKD4ny2sH+LzwPc1OFhlH9kfnAZ0ReCrSg
 ARGvX6zA3YrS9CTUqx5S0PmfH8TNKI3c4gYFFuP0QDzxfI/ToiN0c7cEVCkShbuYsITSCrQF3
 JhWE6ozrdRF46pLetbipy7XhcdYyw/a7nf3WEfKvJ60kQ0x87vtecHR54y5nMWKZi+oqvGWCO
 tVWXvElPhHeR1/5LDYjLvkf7oluf/e+Jk5/6m2jryyP6ophyHpdvQ7QeRdRxGiE/F/UZWBywR
 lMYRVNetl6rv4BPszKrE8e4kwEmH2M57eawSJ13jESjJ0OD4QhdaaDswYRAzDJIgth0lLpbWJ
 HTZ5sB6z9I+Z/wMdw9D80XRj7NnDJWiNSFEj0dQTy/ZCIPq8NaK8BdpidyDY+bmgkI9eZUu6+
 VyKY5qWYzyD2qzagJx2Cucf6/Usgvqy0z10wAaywEC92etQmYGELuyCnu89V153R5p07fBMEE
 4kMXsCMdZNvXEEt8jdtZ886ibOpgplpL2lQaJKfRwk4jmVmbqpb3qoljInMT/bWUYwoqSz0tP
 QxHYJ7A55dS/kqbP9er5JIl7ZInXj9H2/0FD5/D/e9vCrlRudRxMytxFOnHOEkB68aoaGD3fP
 3TaemvFV/jV+g8uZ0iPRdDv1E4agmniA7CMVPvqptlt8j76dTtQ32Wjpqm1DoulfKyvAvo/Md
 LnsLmEgOvxRGz2xdteggVQmdMMyPFdhJL87dA67WqKeahQ0g5gDhdZB/DUmRh7+swOSdOYz//
 d4icXzc3sTTQldbHzA9gvp0C2xlUza2OPMs6+se2Y49pcc5anXrK4qexm6tu7VZbifY/cZnUT
 Kl1fSr0y1VzxTaRjASLXb52eGlRjJ+WabV2TXZLQF9xB+H+WT43dtjNPlwy2y3MPFbsNzoyGr
 KTRGGC9EXUcj7xHPikwunlRBOMdrTXvqXK5Bc4M2QOpCLPwG9NQo9kYsBr3lDruJLNuRbDJFa
 GQurBk2CIoqb4crVOP8SY6LoGYTWrUPHrcJ7UdvemYiH2Z9KKyFB+sAOsYGeQc0AfBBbOQp6g
 USV/N35Jn2SANt4FpUzpZoDoGqJIBihwTaaUpKWW6M0n2CAIJcSOvLqng8h2QdWZCPBE+gUdS
 4QPkqfbv3kGW5hsHHnQY9KC3P8s4bYtNS5S3ca5l1mz9tpG3mVPd9aTlzm2sR92666LyaKLn8
 cuYc2pFNHWlCJ+j5PcfWzLS+91gP832Qpx5wyIl/e9YCtVDIho//kKUQqcfIzjAxovOmslmtK
 WetaZWF7Va8/1Tb88PFX+AZHBbvAYaH6+SFm1Z72ayYxW8DmSOYEW7/c5eu0KyzpN5Xn/znZ8
 5NyFf8oMQA9fVbWZu+8i2QEjDAEczG87bLWCbEOQFgK7x6AC8+sZPb2ec1FZkfVTKXbyIenDv
 XgAhjMcRjdiUChcyvkofWE/hXZS9gLGxp8D6k8cS5yr4HHze3KHrFsdGUlreABhsu8Y8I7I0m
 pzgniW9d4G5Pn/pkXaa4OMz3e2cRLN07jkny9Z13soYKYf7Kk0YYhQKIeDBi/ZauxNiAduBhc
 JayM17Y6L1acS5lNT3jXtjo4PY4NCIfzhh9XhJNpxC7LcThqJXyQk/dAxObsqedQvW4TbmDRF
 qUdHnfgLkyrJx8LWoIZiuJW7KgQPI2FE5aZFTPa4usnsTl0TLdchVPaP6fWbcfZaX135iXuRT
 y2l8NFbDUt/IBg5I/AnuE+hJAiO7u1RF/BMweOBVkVo4Y1U3zgAvOQEtnNu7h9a+Nk+1LUuXN
 80hTkGRRwpn64hPQuQWPjIkEzUISJUdRdEKGiFckXD5OAtlZaZTdpElKu6zVuw+KjhxoJnHkI
 56ZlbfCaoBKLQYD/d5RS/hq6zbeH5S0GXrZZJkw47Bs3Gwqp56mZC3VxXkpdffzUS+EuK1AB5
 Jbt4HzS3uSkToFvHf7imQz9y80VV/MVynxIOq1LHSLISfo5qGYUiAcHrm68JQB33H3gGU45n7
 0hYnCW8aHj1Um8eHQ9O4mxohpiif04X8Yi0wVJRCtMQAelzwCsKAa0jc2pCYZojHcMPEmd0cK
 qpPE0OEFuAtbQK5Sk1SWApF/ED4I/9BrQjQjaWcwq96N9yNnmyb2zOlADnFAA1KcuwypEomEU
 qd5bXOwpXGIKZu540ZnOTB2cwktmvuVy3bvP+9EOsQE7UWomT19vwlMdLZf7172P5u0t9U/g1
 keO2oie93cg6LavYAT/6oG31zTLxoWIiPaR2FXlcrrn8YwfCBp3m6oH4eeNqcip5zmzyIm6OO
 Nh1gJpgIhdOY+HOiOAFFOEOS/PrTCaGbpV102nY2g+G1VH/HDfx6VGOmkegQ/k8a0FXwWHVvL
 1jpb4Ba1sKain/B0Y40bm8Uto2cVKg8Ek0L2Z5AerJ928kaZcwU2VvexJsDYLgrXWrJyM3X4r
 J1Evr/R3v11HUVbqJmjA45/ZoVGcyYMIP32Bzo+whJmOe4ExP8a8ms7HaDamvkeMBK3WPH9vU
 MdFlTI1djP6YqhW6KTBveGz+VP2j/8OI37eMAvB0UJGKo8aoQ4Z05CRry1T4MVib+uGImQ8Hg
 FFpd004isfhlwM+Cx/6q199Z499mlkuXV0GsL+llxPCJVAJitP1FYHAcMk46yM5b0vmpnw6nI
 Ol++72IKjVTCETLtyicMYGyM3Rh5tWXQZfOwYoJgeG81bK2D5QrlBilU8ODXB+n7ccUEiT5Kj
 wPYkGTYldYV3mD0SGwpJoZPe3oy2EdklpOTlkLtXrlSGSqY/+XEGY8UUjm7zV+WEBzJZ8+zyW
 +/QdxBwURPFnAPbwbg/Shpm6+Qz3eGwBWU9Ny26yBB4g8yM/2BzuaWobHfDBUR5+g5XGIAzXD
 fZtO5yy9qS6g+4a/BC4prrlR7Kaf36yeN2QU7xDzx44RkT00fGnP0+m+Juvx/L4b3VM6GIhja
 jPxC/gLF1eujKl0Fux24X8taqms3z0Blx478gBRyLThX6Oz3LUFoeDdG+xnqIx2emb/y10ys9
 z1a7lzib8laWxzUlxBkPL4Yi6vvR3Ft/SUI/lvReFN0czax48uuuHpdo3n53jXjLwgQqbmF+m
 /kF8/Ao0gHs2Y53+qr5yTJYCABWElFHoE/Rz3e5wHCPTtOd/1UrphYlJ9XXEUKHMc3z4FVvLL
 y8m+jBMTCdfK9cAcNaR4fVFiMN6wLLfAm+OvnGV9GHwJjfiG4DrUnn6ADhQfFxvgPbA4l3ZV0
 E4H1aL4i+zZ0oCtbDD3wK0MWotHh0oju58ZEvo8zTSzi/myUm7yz98+Qr72iRVHOY9OwxxFU2
 63NYcU/yrF/TsnS9gd/IFZm7/qdRjkp4fxaToHH25Q7PTndz03dqw4wS7RYHLW9CsDUg9UBCp
 pFVSQSGeLFsbHEBLVKznkoBAWK2CEenQo55ETvOIXf/TUIVuw8Cr4pWBLhbKyQETbAtWElRhQ
 pnRv/ULhR2ooPgINBRGM3x9GdXznRrZFuqu//iZwczagk7Rz/UvV0poH6KnwG8RLOR6aHhh44
 GjacUmM0YBuLv4u+8kiLgH4Ql7hdDc/e4+V5L7l7TioDEfnfx7GwamwlBbdDixNko+QFxVvmN
 16KWDX7lO1ciw9YJAS3u6pkuXZXMs8W+5M0pfohjH7dc3BB9RuhNHb5GuVsmTMWbmV5qT4em9
 L/E9WWRA0/b9XXo1s27Z6/rd278Mudqb822EQLutN4TztEtm0toRxnVoIdrQmw3d4ZXMf7LDc
 NyKMFB6aVRsXDMnCftSfKOQ4kCn0f7a3Go88Ev3d9+f1rwIslviwkYuGeyzzOuok7RIWdR33m
 viG8dAvYMbGCBNXScvBrvGO6KJ7BOsMYtTs/eOki8HYldooOC+2FICexndrMjhky0l1XpQuss
 V+M/abf9V2A8ZJDUt8tokB971VGKW5NRximrZjMsGF7U2AoMFVUS+XxB4V25h8lmWu5NmbZwD
 vSYqg1c24ERY6QyaTT86zvXdMirdvIJug2nvInRWfDwQLOQ4dohNjPVZJ+TJka/bFEn0K44H1
 pLIyLzDyVPuAaxYuZIPA+OGzp3CXyTwu+WbUdu5SyVd46CIHq3h5C0MFlnCVsN2Y4/X/SSe9s
 u1/fWvo6e2Dtmhc/ZDv7PPl/+OI1gs/brs8kr3qq4HiGJlLK7hozxhXqEog/nslzbw8Gt1ZCK
 E0I1wWMMZ0oSILvmELrL8djeGCYDgtKoakkXO9EJOo3HQLXMCY+1/1unQwQrhnygd4t4cKJlk
 /3l65hxFWfHO4HQflfBqXVSo4F1WE2Basn2kg6j3Dt+3M9T1E80Gv8xHAHvDGyQ8Ld0RVvU0P
 LJ9xRGCneT596GAfya9wtaTQ5KH2eRW48jbF1XHoa5Qv4zqHYRuBcfhTjGg600VUB+XJ1t+Qi
 Vq4qekJ5XZ+E4YfpLGwjbjl5qyLzOZmQyeBi71pdhvQiUHUij5hB9OZ5AL7tRjXdlurT85IeV
 LQ5L6uT+wf2hUbCEJPUxGv1HBFJLbSTHmb0PfUTJU3Lhk0KOnXmSSCq8v6Q6bXMIDn//dRgvl
 uBUlhgavSPJ7HIM+jTIPfPnA261YuSxkon6z2xtGq3HfGQwt1fjI3KNFR9ULcRV1E07lnc57Q
 GWgkiTQiRWn5Wm9g8eIMW97DdR0v2A=

Hello,

I am experiencing frequent boot failures when starting Windows 11 ARM64=20
VMs on an NVIDIA DGX Spark system with a heterogeneous CPU topology=20
(Cortex-A725 and Cortex-X925 clusters).
The failures can consistently be resolved by pinning the vCPU threads to=
=20
a single CPU cluster (using taskset), which points to a PMU migration=20
issue between clusters with different PMU types.
I suspect a KVM bug where the PMU state (specifically PMCCNTR) is not=20
handled correctly when a vCPU thread migrates between physical CPUs with=
=20
different PMU architecture versions.
My KVM host:
NVIDIA DGX Spark (aarch64)
CPU:
Cluster 0: Cortex-A725 cores (IDs 0=E2=80=934, 10=E2=80=9314) =E2=80=93 PM=
U type armv8_pmuv3_0
Cluster 1: Cortex-X925 cores (IDs 5=E2=80=939, 15=E2=80=9319) =E2=80=93 PM=
U type armv8_pmuv3_1

Kernel: 6.17.0-1032-nvidia (Ubuntu 24.04 LTS aarch64)
KVM: Enabled, all relevant performance event and PMU configurations are=20
present:

CONFIG_PERF_EVENTS=3Dy
CONFIG_HW_PERF_EVENTS=3Dy
CONFIG_GUEST_PERF_EVENTS=3Dy

Guest VM:

QEMU: 8.2.2 (Debian 1:8.2.2+ds-0ubuntu1.18)
Machine: virt,accel=3Dkvm,gic-version=3D3,-cpu host
vCPUs: 4 (sockets=3D1, cores=3D4, threads=3D1)
Firmware: EDK2 (latest upstream with LPA2 workarounds)
Operating system: Windows 11 ARM64

During the UEFI boot process, the Windows Boot Manager (bootmgfw.efi)=20
calibrates the PMU cycle counter (PMCCNTR).
If a vCPU thread is migrated by the host scheduler from a Cortex-A725=20
core to a Cortex-X925 core (or vice versa) while
the guest is accessing the PMU, reading PMCCNTR returns zero. This=20
causes the VM to get stuck indefinitely in the
calibration loop (at the TianoCore splash screen).

There is no crash or kernel panic; the guest simply fails to boot.
The issue occurs almost every time (>90% of cold boots), depending on=20
the state of the host scheduler.

The same VM boots reliably when the vCPU threads are pinned to cores=20
within a single CPU cluster (e.g. taskset -c 5-9,15-19).

Claude suspects (yes, I burned $50 worth of tokens for the analysis)=20
that KVM's perf-event context does not survive migration
between CPUs with incompatible PMUs correctly. This could cause the=20
virtual PMCCNTR to become inaccessible and return zero
when read.
my QEMU launch command:

swtpm socket --tpm2 --tpmstate dir=3D$VM/tpm --ctrl=20
type=3Dunixio,path=3D$VM/swtpm-sock --daemon && \
qemu-system-aarch64 \
-name "Windows 11 ARM" \
-machine virt,accel=3Dkvm,gic-version=3D3 \
-cpu host \
-m 8G \
-smp 4,sockets=3D1,cores=3D4,threads=3D1 \
-drive=20
if=3Dpflash,format=3Draw,readonly=3Don,file=3D"/usr/share/AAVMF/AAVMF_CODE=
.ms.fd" \
-drive if=3Dpflash,format=3Draw,file=3D"$VM/AAVMF_VARS.fd" \
-chardev socket,id=3Dchrtpm,path=3D"$VM/swtpm-sock" \
-tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
-device tpm-tis-device,tpmdev=3Dtpm0 \
-drive=20
if=3Dnone,id=3Dnvmedisk,format=3Dqcow2,file=3D"$VM/win11-arm.qcow2",cache=
=3Dwriteback,discard=3Dunmap=20
\
-device nvme,drive=3Dnvmedisk,serial=3DWIN11ARM001 \
-device qemu-xhci,id=3Dxhci \
-device usb-tablet \
-device usb-kbd \
-device usb-audio,audiodev=3Daudio0 \
-audiodev pa,id=3Daudio0 \
-netdev=20
user,id=3Dnet0,hostfwd=3Dtcp:127.0.0.1:3389-:3389,hostfwd=3Dtcp:127.0.0.1:=
2222-:22,hostfwd=3Dtcp:127.0.0.1:4445-:445=20
\
-device virtio-net-pci,netdev=3Dnet0 \
-device virtio-serial-pci \
-chardev spicevmc,id=3Dvdagent,name=3Dvdagent \
-device virtserialport,chardev=3Dvdagent,name=3Dcom.redhat.spice.0 \
-spice port=3D5930,addr=3D127.0.0.1,disable-ticketing=3Don \
-device virtio-gpu-pci \
-boot order=3Dc \
-qmp unix:/tmp/qmp-win11.sock,server,nowait \
-display gtk,gl=3Doff \
-serial mon:stdio

A725 cores only:
taskset -c 0-4,10-14 qemu-system-aarch64 ...
 > Boots reliably.

X925 cluster only:
taskset -c 5-9,15-19 qemu-system-aarch64 ...
 > Boots reliably.
Without taskset:
qemu-system-aarch64 ...
 > VM usually fails to boot (in more than 90% of cases).

The hang occurs early in the UEFI boot sequence, before the OS loader is=
=20
started.

The issue is independent of firmware patches (LPA2 workarounds). It=20
occurs with both original and patched EDK2 builds.

Additionally, I have observed a second, potentially related issue: in=20
approximately 20% of cold boots (when launching
with taskset -c ... included), the VM hangs for about 50 seconds after=20
the UEFI boot screen with the message "Display
output is not active" and then automatically reboots. Windows boots=20
reliably after this unexpected reboot.

I have not investigated this issue in further detail yet.
I can provide serial debug logs, QMP traces, and host-side perf-event=20
dumps upon request.


Best regards,
=2D-
Jens Neubert
