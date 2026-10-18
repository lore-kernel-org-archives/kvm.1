Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461F2286A5
	for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 23:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792364591; cv=none; b=ln6LiTsQDJBetc3ePhQgKo0XCMFNIc9xsSWjdZiOa9LCKBI7f61pQuSstfwTBzpvP4UNP7qGEoYB2QFUsy0PuIPTxk86XKGOXcqNKLiYT4CCK5bZXzVUmNVS3t1+a1gs0TA1MimiPtMAo/5XGHS3r5fTC4NwDPsYcNDxE/sPgk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792364591; c=relaxed/simple;
	bh=GKoOrgtmC4bETRXt7U1pPUsjDjudTm9Qk/43WXW2pNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AxF5hw6GKuZl6C95cVDgR57Pxh/PWUYRVC8N2E3SCaAoGhNXBXEl+AxVc3pIjs1tQfCKGs1KLEIh8ihcYQXuM89tQerZNdWzG1bFgafMrkMYXuxCobzOs/baPHBfxLd69hhlxRC5BwvS2Frs1wTin+IXhs+IvplbN16PUlpRDZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ek1+WxZy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZTCCClIf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ek1+WxZy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZTCCClIf"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ILjeAk1312496
	for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 23:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PRdRT3I+2Qr9zOeyTrt7HB
	iOoRTC08GbSmLdcEwHXjU=; b=Ek1+WxZy7gYgdnFLlXXmv7v41letBJCsb5yogT
	3hxhBz2+kyOHmh+KCWeXHBXQi66ALDVegOYg1rJEpVsX5saS04n27yd5HVkxveGS
	ZI6HE453w4OYlCuWv2PXlVncNglRPVuiddxLRhbkEwsCHkf9B3yFGtl8ImjaNZhx
	0XJamCXQCfT+dp0ef4lc78R8b0YdJNqDPC4ZiQpV9XLnxeA5sL/y427V/mtXmhP6
	kf2Rxf/U1QF3CRiu0oHy6WzgB9Bs7RiGMsRP0/4tPeMUz1absPHwoTIycSBKW7cl
	bZ2G9opfx2H0UObZW0jpW9iN31U4GVxTZlx2CMYfFhCWHBKg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5u1g5dg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 23:03:09 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c96bf59c31so305803e0c.3
        for <kvm@vger.kernel.org>; Sun, 18 Oct 2026 16:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792364588; x=1792969388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PRdRT3I+2Qr9zOeyTrt7HBiOoRTC08GbSmLdcEwHXjU=;
        b=ZTCCClIfyB7Hkk7ZgAA7nuwZf59DfAL1PNBbzxukokA3eU6QjRq8IqCAcvaGfEiimi
         zVZHn7eggYPCXVMF+PU62sBK9/YoyegnNFX7XHZobI73/DKMt+TjX6Dt9iWvEo8BbsMU
         gbDzbXDGK1vksxxF5jVYIs8OFkkg3vjxJN2plsHNnGOVKxu6gPcRczVd9Kme9cbPI4dY
         ePrABOYykONODJLueVxZBpJTF2bBiPXSFhGb9GvI9pb/SCim1CGkxTwkIpJ/IdjG9/zH
         oUt7V4U96QO6WKqcID3Uhu3IMFteCVoTiNgpVSm8d+GB2tmDKV6TZqn7VhhAsiF/Ic/e
         QCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792364588; x=1792969388;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PRdRT3I+2Qr9zOeyTrt7HBiOoRTC08GbSmLdcEwHXjU=;
        b=Pq6ERbCaaST+lvl7uByme6MTXZ50h9SEpcEg4aW9zRp3GNQxU/0YUikkytb2wCKUyj
         k3Z/c7EfwpNNOrH6bYoGlK3n4QxhGBsUpW4jI/dTphQKsFKp87hM97tAh/Q85Eqpgbi3
         3TfSq63R5GrQc2aPl0rlXtqgTsM3ognF9Fc6fktsAlOD1eZWnJYQJeUSTWOoofk6Snr3
         JX+AVddZDTe7iZ5HFC0z7K1VH52uFZj+qMDO41K29XLRBPJjUlUKsfqBju7/E4mLw7ls
         czOtvpqVu4PlshH7r9vJQTUhpttu5ebfG1VeSEpnxfailovP6gqQ1V2jPDvQZfiburcL
         wEag==
X-Forwarded-Encrypted: i=1; AKwUvBw8jZ1L7SLw+LHycM/cW+6wU8xBl0R3bzp4rflaZatmfHMcPasztD7eGpsD7ylE1wOEmxI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNcYT+6ukDOFxVKi6k09E3h7k5ufi3MlmiEineQDN0jK6onNDH
	ee6WDwOYkAYeKT+CU1/zEc6YgaR7ewfP8S21zPwS7DjtYTtlgG3EtDx/hrVBwxAhnqTJgDkNHFv
	6apYHMHaLI1QJV8fAD1jT7U8IGTHnBVp80QMA1xqgft13Zx9DqMiNgPA=
X-Gm-Gg: AYBFou3s8ICJWWPuvcMX3/0GlMD7Ln3V8ULpUEXl+fPA33TTcPHLMmjjTo1zxJm7hb3
	O3Ky5S8ahlzWrOYQmEPpsV+H6b+A6x+Ulfz+i9w9nfINhQ7Yo6ifY94N1TUZNUBnzyud4/1i2xe
	g50LI4wF1fsn0x66OjkOaK+S6j/CTlbEp+Jr4qI8RNGYzg2jhn94Qjs72hAZctWpZvTmv7YmHZn
	rDmf5smg/PDAHECk8nwraCsrU7EYWBoymNC9/ZCxOBnCjQI+PzbqeMLrFfzn9Y9qbbmTEZS15jK
	yR9sxNy+uBiEE37Hc2w8XiVJGHiJ8JsYKWQO+8BIzY13tmc896Kn6jioozxKttWpIC64/Xk0CXB
	Uwz64B/VeboxyIvsJ8JYIaCHqF9PwoISY6vGbjDmS
X-Received: by 2002:a05:6102:3f8f:b0:7c8:1fd5:82b5 with SMTP id ada2fe7eead31-7cc3697a7d4mr1431221137.14.1792364588382;
        Sun, 18 Oct 2026 16:03:08 -0700 (PDT)
X-Received: by 2002:a05:6102:3f8f:b0:7c8:1fd5:82b5 with SMTP id ada2fe7eead31-7cc3697a7d4mr1431212137.14.1792364587734;
        Sun, 18 Oct 2026 16:03:07 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ddde4esm283444135e9.12.2026.10.18.16.03.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 18 Oct 2026 16:03:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        devel@lists.libvirt.org,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        Markus Armbruster <armbru@redhat.com>, kvm@vger.kernel.org,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] docs: Clarify 'query-kvm' deprecation release
Date: Mon, 19 Oct 2026 01:03:05 +0200
Message-ID: <20261018230305.6239-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Qtb3im9QU7oUA-NrfmIolctEk4wqzCo9
X-Authority-Analysis: v=2.4 cv=NItAaE6g c=1 sm=1 tr=0 ts=6ad5502d cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=uhKpQFyuRnTRNiYsaUQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA5MSBTYWx0ZWRfX8hazaGbd5PYW
 HJefONEE+B6UXdm5E1iLf7XxSWnRBb2D4LwHipDF46vA1BUnJdPqx39KTxar/2Vh+DJiDyRZN3y
 Jxw+qF6vE2xNvlO7ebAXoQHzW01YGu4=
X-Proofpoint-GUID: Qtb3im9QU7oUA-NrfmIolctEk4wqzCo9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA5MSBTYWx0ZWRfXza292Q5BpHI/
 QzL0X9ogiLaIKgb+64msfxkZMcldJ6t+SJc6+eXVGeTygaNQR53otfsTD6c9Uao+lqBxHYrsMTJ
 TWRRcVcjoAMIuBUenT+9B75vJ65zBmKDuujJSpBzppHZ203fUJ8qohqSQASHqdyDqLaThf1D+nF
 HXtXIpKIDIzoDQcEE02sd4gmgnsHULSF610uBvWWPlCdbAoDzBcGTjmEKAbnQD9Wjkh+nQL/UDm
 2Y9e9asFX6bW+U3boW96k84k03Pj7yL2AVQof/GbON6cRqfnXfqGHgBys8/eMXIV46Z45jAAMrf
 nMI/JcZpNLuEB3JB6KpWrNWx9Jdqk8p6mX5PVT8DeZlbDSFa+5TkjgF7nj/N+Q506H5KLathKMI
 XoVzTsp9mGWiYGKfxRePh379RRxkyzS3IN9QFVhJfBuNK6KKMqa6hHk1lIfnAcc5RxmjHhr0rnL
 x+5wGltud4T2LbyKMcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180091

'query-kvm' was deprecated in commit 824141dcf48, merged after
the v11.1.0 release. Correct to prevent too early removal.

Fixes: 824141dcf48 ("hw/core: Deprecate query-kvm")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 docs/about/deprecated.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ccbc4219497..2507a86d1ee 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -168,7 +168,7 @@ Use ``job-dismiss`` instead.
 
 Use ``job-finalize`` instead.
 
-``query-kvm`` (since 11.0)
+``query-kvm`` (since 11.1)
 ''''''''''''''''''''''''''
 
 Use ``query-accelerators`` instead.
-- 
2.55.0

