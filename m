Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B8D33EAE6
	for <kvm@vger.kernel.org>; Tue,  7 Apr 2026 10:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775557104; cv=pass; b=OnRQSTyEGL2BrAFiZWNvpWNir6i7q6S0qgTxtq/awElNn5Z+AXBypQJ9/fTwjs6NYzGt/BzmVvIznfLFdSSzFQOjClh41nZceUpQN7VTr2aHEBUgo1YHV+nk1QSZE5EeZhUmPEL8CFMr1dRpMFlp4LtZSmJ65LcwXSXezKq7XLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775557104; c=relaxed/simple;
	bh=ObnjNsk8R+1s/j5dZzKFy+eMS6WJBMJERfIFad2mocw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ELHAa8uybT8ukD4ZRb9SrEqsr5gV2sIDPlqxjpGMTZlEuH2jj58KP0F5lr0U8i7QpyVOkgNPZrPEjNVf8woJ34OaIoI7dwC7eyx9HEhtWmjGILKpHaBB0xXQlJBNpPEnj9m8j8g65aWVtBE3T3/kg2NqAnooUB0Lr+wOQdylO/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f4pPZXnY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ba4YTyUB; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f4pPZXnY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ba4YTyUB"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376O0Le3402569
	for <kvm@vger.kernel.org>; Tue, 7 Apr 2026 10:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ObnjNsk8R+1s/j5dZzKFy+eMS6WJBMJERfIFad2mocw=; b=f4pPZXnYhD+F3J+B
	ohpPYB7iiQsK8DcyYdnQ7Hj1phx+h/czfbNA5IOTZx9TpRgYqa3fSW8Tcb8SRIcg
	HvAPIr8wV+TYQGv4dGdJ/JaPkFEKgUG9mfJUMU8ck35RIkUQnL/Fyf8DrIp1Le1q
	qysgb0KSHWA2NkYLRvTPOeu/QFJzEQfjXGZseAgo2ylgo9qcNPGfmciqIpWwSwvs
	bSX+g2QASRqu5mxGQo+sbrjchsVyJ5XdAzKxM5su+0WDjFydaMRYaSILvv2966nY
	ifvo4cvpagMUIHkbi5XDeO/Pr7HkrYvb2So+mNUoY0AZ1tkDEanbXMpzcYgUPoxf
	FzKTKQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrht7r0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 10:18:22 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8d6061bd722so574031285a.3
        for <kvm@vger.kernel.org>; Tue, 07 Apr 2026 03:18:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775557101; cv=none;
        d=google.com; s=arc-20240605;
        b=Z+G6mSIY7HS2lQSEhDZwljRBO3N0CuLbnEvRabPp/jaZcN5MZEE/Of2N9EJ8RyjyFc
         RMqA6Cx6FQoKI6USKKdYTFY5fsTS9zWE7gj+ZIRBpVGgZEGomzoNHGFQhW83cfvpXkEc
         UVkoTUh2DDHQ6TXRV5H+BAGvG68zAkY7+txoR8DThx1Ul8elC0pgLxTnQJ5+gvWulXma
         FTRxmdEj043w0VTIjm1P1SB2DcWWrp3uF8IzMBJIKw/Iet6GbjAOdGnZ/kp3h5pSSSvm
         ujADmx1hJPQo2prWYW+YZPJZHw+EOiG/YpgRuBaGIuJ5cFjZi0ZGgrq1uxHDr0Yvz2dB
         9y1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ObnjNsk8R+1s/j5dZzKFy+eMS6WJBMJERfIFad2mocw=;
        fh=Iies5Ww/MTbJCPdwxlbphMjIJKNwVHd5F3zwa2nd4d8=;
        b=lONbMIjGBvKAyhHVUF+cUjvIgkFZ0SZyjfRJWRXQG8CTPBwnTztHuXXxIUQzmZhR9F
         Q0cU9PJ4SWe+xXQ6WdAJsB39O5TEUOLHCIeEY5uwvLb90IQKjKOAhdzYv95BKbE996GF
         KI2dDHhPodtH/jFWbkgdrEO+GZfg+TOZEJ5BgaLExO5lbioEprB0vyDg1jUqeXe97YPP
         RZrFWZr6fURBxA8b2sbHctuX/84D9rBX1f8h28ak6GlzlE8fKO9rDhy+zD+qukjeTfG4
         Q4qQDuO8UQ2mSTpIJ4YM5ltF4ASCljkOgKyMEqgBmvTWLIYj9sqr7T9gPmgvc16WecFI
         dmtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775557101; x=1776161901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ObnjNsk8R+1s/j5dZzKFy+eMS6WJBMJERfIFad2mocw=;
        b=ba4YTyUBDiH4MVXYO0C0pYNFo5n7JG6NqGdkHN0l/GIqko4bEUPx/D7zVNO59SFnem
         Nbx8FtTTyWy+M1qjWXgv3SnIfooDWgJH0QU3A2Td816kf9hNwCSUV8yjqCjq05mjZDoK
         eUpMeI3wdGf4qIUO62q70JqMAaIh2HaMTKlweVZ0NqxiFrbRQka2D3WpusP/aTVT57D4
         9gcUJpxZzfR5QVbxfHMnBOsXqjs0SeScCUdyOQsGffKn6+g/d7tX2WjB+TIBxIBJ+3vS
         PhjW6vjSv/n8sGQtYsaV/M877sZfDwFp9tPB3VdR38H4sWuqPmAXM3ypqdGuZhuE2pMY
         Z05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775557101; x=1776161901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ObnjNsk8R+1s/j5dZzKFy+eMS6WJBMJERfIFad2mocw=;
        b=BkzP4nhSOwoADHF/pSYy/jRRogSXdW4ulPdaxRwSpgTiPLdc7DkJpkbVbaFH4tBBjA
         AhZqWBSGwApn102Od8FwxkUoqOcJON7fDpfFVYmuJMg6LfFn+4Cx77UDM4DK80AkzQWd
         rncqElZtphNkR+8Jkx+D7JbcyZawZQJYhSyvZ00z/kP8m9NlVFVUTFh2yt5l+Mnhlv0l
         ggQXBGBa2Vx5b9cQQwx9Vh/qeZ2qIBO+7Gu8/hV3sFl8msb6eCNwIEezwHnEAkB2RPKu
         aW4DwITpvsM4wInmOi+xLfBrleAvhVFfVI5yVUebplGzekflyGXRWLFeC5seOxfpMG41
         lwQA==
X-Gm-Message-State: AOJu0YyyzVyxdFGnL6cZBTeptJIN2qt3nxH311+IvKZNIluH5DfNchME
	4iB8+4vI8ioFz3wSLEz5ok9jPHYqxsoh5+yn2uXpVuWlT8vLJrwSPegLqAZqLa/QdA58WSXqXgz
	xeeEOEctioOemmIJUwbKMdMjGZ9mIioA2j2oFeCJ+rH5rwpk712c77KmwPPa+1tCulcZ2J/STMH
	A9ECENb7RO+dOiDeq17K69skCv+JHxHg==
X-Gm-Gg: AeBDieuvbD7IFh5AMaA/5y7GHBRM4Of9biVJ8HB7/u8IodwDhJPKSbdU7h8ADMBncF7
	mX6r0iJZUfYknrLmoAXHWg2R3HMd3Ax6VSUkl0iNZYlr5glUQ+M5glKM6EuwSm2TXrHagVQw/o8
	2k+mRtaNK9762RcIOsbCQwcbcebf3HiOF69/jECbhbcOiQmZ7cEMoM2bU1zaZCcWogvJaWkCYJ2
	vS8Ngw=
X-Received: by 2002:a05:620a:404e:b0:8cd:9665:9ef3 with SMTP id af79cd13be357-8d41c6abe9fmr2357254585a.19.1775557101403;
        Tue, 07 Apr 2026 03:18:21 -0700 (PDT)
X-Received: by 2002:a05:620a:404e:b0:8cd:9665:9ef3 with SMTP id
 af79cd13be357-8d41c6abe9fmr2357251885a.19.1775557100987; Tue, 07 Apr 2026
 03:18:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402102953.2984284-1-mayuresh.chitale@oss.qualcomm.com> <64d44f37-7d31-46be-b9ed-cc86969777dd@maciej.szmigiero.name>
In-Reply-To: <64d44f37-7d31-46be-b9ed-cc86969777dd@maciej.szmigiero.name>
From: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 15:48:10 +0530
X-Gm-Features: AQROBzB0qcqdfjosP92annvEyb_7a5bp2GhJjVdK5-ke3HSPxUq9cisp7D6zOPU
Message-ID: <CAHuiULDWrraUspHZSDCR1HFZrZdevr7x0GLy5rSni5T=N4upgA@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: memslot_perf_test: make host wait timeout configurable
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA5NSBTYWx0ZWRfX+jqmir4IUF8y
 7oagp/2k1/H7TS5hLxZzdSfwIOhVbyPqzEuQp1nRTu98RDlCDy4Pv9rbz+kBbRkraQPZcSaqUNj
 ujohlSZZkUhIv8PlKkOrkXGavgvin3liz3LNBrZZ2cAcF4GsQiy/3I4RZgnSd2lUfynwdBGd+FO
 D4n+pv2d815H6RLup5fd5cDQxV77sFFYcd7ONcmJ/045UkMjsm2ahvyA3GCDwpRVIRTaSwMwtia
 hn6QDatoURBLCVY8tbGTvf6chzwoOrVtRBq7bN90zNYDyjNSoT0eQ0EtOdMv0XHiMcGDjr7sSU8
 m2ik8eyWb9dhVrMxGSaY1RB635s2Umom79zSP+5Vx8y48XxjmXLtM3QE9mqkkA40WED82p1rdiF
 Ve3965SNTJmsIG2YyzwYmWKpOBhexYQvl8Z3QtUFhTfPNm1bYOzzKaNRdSAuQr6ruvDSozPIB8d
 S7MSvs5iMbYeDuTV9XA==
X-Proofpoint-GUID: mr2ZI-zu4AXoArrUpsaum9LUemIIW3bH
X-Authority-Analysis: v=2.4 cv=XPUAjwhE c=1 sm=1 tr=0 ts=69d4d9ee cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=BNrK-vKlxPOWU8-VGi0A:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: mr2ZI-zu4AXoArrUpsaum9LUemIIW3bH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 adultscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070095

On Thu, Apr 2, 2026 at 11:50=E2=80=AFPM Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
>
> On 2.04.2026 12:29, Mayuresh Chitale wrote:
> > When memslot_perf_test is run on qemu, sometimes the RW subtest fails
> > due to sigalarm, indicating that the guest sync did not finish within
> > the expected duration of 10 seconds. Since the current timeout value is
> > itself a bump up from the original 2s, making the host timeout value
> > configurable via a new command line parameter. Now the test can be
> > invoked with '-a' argument to run the test with a suitable host timeout
> > value.
> >
> > Signed-off-by: Mayuresh Chitale <mayuresh.chitale@oss.qualcomm.com>
> > ---
>
> Out of curiosity: which KVM-enabled setup takes more than 10 seconds
> to run that RW test?
> Does it have like, multiple levels of nesting?
No. It was run on the Qemu Risc-V Virt machine.
>
> When I wrote that test I calibrated it on a mid-range x86 machine,
> where one iteration took on the order of 0.01 s.
>
> 10 s time limit per iteration is already three orders of magnitude
> slower than that.
>
> Otherwise, the patch looks sensible to me.
>
> Thanks,
> Maciej
>
