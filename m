Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6003515DC
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645073; cv=none; b=E998rxa/6W2ZGx4c9u105+ChfnhMJiBK6q5N9ON/5ux/7VIQrHZl+8ZU28xhcsBhfiNJf4orX7XrkjRpvAW4bC9131boee4TSHtVzx5ihIuYMLKCCkmepAa+BhuwbVpLxLqJhoF2R3nqY1ikauq/njAHkTZz12x1kaFxfk/052A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645073; c=relaxed/simple;
	bh=mmaI7+y4/C05EWfijxcqleh4DRD9KUsSNL+zcgswCLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qrv360/5sm1Pgve0JmmDO1xpzEEjuWH/MGliOJrTRF4pHIZxcflxfkd6vKat8zBhmIlMBsxV7jJoN6Ia01MRQbCdMQg1EiMxJeCZKbM/aPyGUMelDMMd1gC8q4kfi9zBr2pEP3HC7SJ/2yFMVOjo5y0g6jqbFA829dpOfeIKZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oF6mDawx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DVIf2jf3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oF6mDawx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DVIf2jf3"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DGUwJE2076850
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ljSN1UdHSOnwLMjuyKlwazgFwW/6t/xeE/JxhEIwvSM=; b=oF6mDawxwkUKSa1V
	xcOKuQGaulTHe6MaqdEQt+oUJaarZ/BGKdWkvD5uOrBhWgs38ptGSCSwpt1DNc5J
	H3TGCA5+VScZp8Y9s2gvHJZEqaaR5rI3TxImWTOqv1Y5tWAGU0nFP8GTWSUtw8DU
	7sbP9iGBCxQjm7AJQXAny+4xkNzn7u9TosWRTEOw1sHEcWWm6NYJSvG04Ta4lb9M
	ANRqLlMxzGdYicqrIIWVMpqg+UHDAnvG3OYf7RJiGBSSWjhtjW0HUlPOflFnyXqJ
	2GfjGd3bZDBGsm5hfxz8mZKU2Tcsc8aMFQeL/lxjmAmkzL2lR+UD+onlib6ZjE4i
	AwEC0w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1hgy0f9m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:50 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52cd0374265so4344521cf.1
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 11:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786645070; x=1787249870; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ljSN1UdHSOnwLMjuyKlwazgFwW/6t/xeE/JxhEIwvSM=;
        b=DVIf2jf3TsJx6V61hKrkI8BtkuUkqsyO6jNISMDh02WdALlrOo2am3xCa9UkAeU3lE
         YEOXiqYq5X6uUnFdW6ctd1Nri6z7fnElb/P0Bpi1DejoXC5HihLv64cDH5XtAKU/2XqR
         6IbAeMipzMn1xED1RQp8xxnE7YhKnOu/qXrC46PgpQis2bXfK/a2pNRIKJ2S10ci/RDq
         z0WAeEyLfKgTyRWIftLMlNzCEDiw80XJA8a1PaNHFjMq9lKOoyW91ChhyJr6dPdxxpfW
         4Aw+NfvJ1j+C6DMabe1DMB+AFLg+GcBGljJMQCmS04djFF277WfGuFxyboi4MFmXj7wF
         I4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786645070; x=1787249870;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ljSN1UdHSOnwLMjuyKlwazgFwW/6t/xeE/JxhEIwvSM=;
        b=aZJuMDiM++kWBXKNKu2f2LqfV1snwlZNH0cciuxOHd+5PO2u/YsMTH3RKrQUP/wQ+Y
         dntkvhVa59SwR79zNaKIWd4roqET3aytAr6vyGa9+mzoTE4aafUmUvTVtmhS3KUwtvv2
         EkIXdy3s7lIfs1YXy63UCTZ0m2pBpRnHytVambp0HPG7EjoKGkFVomdF2ROtWCzLxQ4l
         xsiLBgIO4ILiG8XKTcFpiUfbojy5pVPUvUtvQPTa+TnilB1J4jHfNCAgt399ZoU7e19a
         8u5X+EdSrtT/5rNJ3UZ0z9LvzKTUOxuHa/A+ILxKlQhsjKbzpB5h51mk6n5DG8+gtMTB
         p5yg==
X-Forwarded-Encrypted: i=1; AHgh+RpbKvIfQ0sZxJFM8ZDe/xwpVuVOKKNajsWhzyzH1TGindOxq6z+/1fH+XcSCUbX/w2cUro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaxpQygsa8yZ5uKiYvL/4hJNMSE9KBSlA9MKjiF++vyKFliC7D
	HBOQkXyMAzom2NE4T8lKFD0Uy/AD7ATZjGeG1VlHzHefKLeyqZQTtHAo9iWZNcKK31UV0VMH/ZO
	2Gn7W2fW7+EuwcjULpYkHO+1k5mhaL7qKviBsHYvbcUyHZzep38IK9ck=
X-Gm-Gg: AR+sD12zJsIqLX/nfmKOTTtubVzAe85x2Y4hc7szedMgrc9vm8MRyctQ1VnzIlPElo7
	8a2NULrQsRQBsS21ebNuB65zgqxfzovLaAD1hZ0veRiasnmEsazA6J79nyBDlH/7cG1YCUDS/IA
	VxswR3aJ9VNrpuM/1GCBIOMbyNJczG3oAnwIIdMTZAgjiSlamiAPEar+iPIqXciDUlBxqWGwyT5
	3lwrzvix2FLFZFu4MKDNPzcndQShWlcjrkyq/Ff4/04xRT/PhhRERMXsiUK5Db/lHowbT/fJnJv
	SBubs5rN7sMHEzFC8AaL3ObscCN+cRhFqtCY3XGBNrdRrzRrYW+DV612W0ytQpzt1rb+d68JOSW
	VW58p78gyK+7aHmJLUdcBChKGVOAdwFJxaywraFHCzg==
X-Received: by 2002:a05:622a:428d:b0:51c:9e2b:a79b with SMTP id d75a77b69052e-52d73da5717mr100236721cf.30.1786645070021;
        Thu, 13 Aug 2026 11:17:50 -0700 (PDT)
X-Received: by 2002:a05:622a:428d:b0:51c:9e2b:a79b with SMTP id d75a77b69052e-52d73da5717mr100235971cf.30.1786645069462;
        Thu, 13 Aug 2026 11:17:49 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f200752sm1249951f8f.1.2026.08.13.11.17.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 11:17:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
        Mohamed Mediouni <mohamed@unpredictable.fr>,
        Alexander Graf <agraf@csgraf.de>, qemu-ppc@nongnu.org,
        qemu-riscv@nongnu.org, kvm@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
        Magnus Kulke <magnuskulke@linux.microsoft.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
        Peter Xu <peterx@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PATCH 09/16] accel/tcg: Use RUN_ON_CPU_NULL for tcg_commit() callbacks
Date: Thu, 13 Aug 2026 20:16:32 +0200
Message-ID: <20260813181640.6537-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813181640.6537-1-philmd@oss.qualcomm.com>
References: <20260813181640.6537-1-philmd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfXzE+zVQIB7uyQ
 z6ELMFbvp7cG53ODL6lNl7LWcIdXpzTe+7yUKnvou5QNqqGbD4Okc05cwSrgbmar696U0nk7wg9
 g7JYoq5EZ+SFLY/CsPpESgk6wbVRy271Soj2nMdnoYD1vi8DH/lmMvNqqm5NNDAWQ00tj7dcTtF
 MuamcBWIQPiTGdu+3HY3uTqVZ5dhd8tA2qvFPuIqwquB5bCKkbeg6LDodH21xg+gMdQp+ngxF+q
 /JUvWt4Pwba0ngZ1kjgyNRG8tabS6ySo1RagJ2jXURW8JEfNGIwjg7n2z8wn7Z5lSl+R3k7wPgL
 C1kd2TVbLtkgW1YY2BPmm6bLdPSRO91OPVnTk1tXW4V4AE9U6PJMTJLQeMB7O7UeHd/bMdEFflM
 coaaP/UyHfXJstLatqLho/hapugAgaN4On6YMOP9YdR+jahXnvwJwcnOF22CC0579ha8ComX9rZ
 SslW28ilGPPv7smmXZw==
X-Authority-Analysis: v=2.4 cv=AaSB2XXG c=1 sm=1 tr=0 ts=6a7e0a4e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=xzjjCr4z5Sshx9Y3hZQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: q2twU9WH0x25OoATqc8UT-TXw4TpsK-p
X-Proofpoint-GUID: q2twU9WH0x25OoATqc8UT-TXw4TpsK-p
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfXziARsy1UHAUH
 nOiy4eEechZgfbOltk3UedQa6OTXnzgXvZJ/aq6Y6oiAa01nSnT0eWX5HNTt8huCOqHcD4Wnlxb
 /sOwxdZHtVdV1oT38f9+gEC4O2r4p9A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130132

tcg_commit_cpu() does not consume the thread-local parameter.
Replace RUN_ON_CPU_HOST_PTR(cpuas) with RUN_ON_CPU_NULL when
scheduling the function to avoid any confusion.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
Maybe this AS parameter should be used?
---
 system/physmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 362a00f76c0..b97016b1303 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3088,9 +3088,9 @@ static void tcg_commit(MemoryListener *listener)
      * all of the tcg machinery for run-on is initialized: thus halt_cond.
      */
     if (cpu->halt_cond) {
-        async_run_on_cpu(cpu, tcg_commit_cpu, RUN_ON_CPU_HOST_PTR(cpuas));
+        async_run_on_cpu(cpu, tcg_commit_cpu, RUN_ON_CPU_NULL);
     } else {
-        tcg_commit_cpu(cpu, RUN_ON_CPU_HOST_PTR(cpuas));
+        tcg_commit_cpu(cpu, RUN_ON_CPU_NULL);
     }
 }
 
-- 
2.53.0

