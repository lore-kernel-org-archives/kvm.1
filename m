Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0A2319617
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645066; cv=none; b=gHonCb14prqvmHYVPggUuSmhy6vhCkuwMmSNNuga6I+/HI+lfmXliL+PhP1X1Lg6o/pryZo8NaPkP1G1Eu9B0hgCY1pBb8FRQOPGkjtSbUj1J3Dzv3F0L86EoCIM/zU5ew/8Oksf44AIDIjJnHvBl1na4IPVmnmidFSnYkjq4Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645066; c=relaxed/simple;
	bh=p3G0BD8zEgvehDflSxLrjNCea9Yr3s5alYDcOfRrjaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eh42kdjNDjKBfnIEduUjz8h+WxLtbJhRrd972W35Y9oD6wIZSV/NTq/R1i/IwBU6kZKVDUSAAWohnFtlWObb2LHOoo7RRapHzrdGQ1H2ePLsEWZrbiquqiR8nYwEtHMfpq94NWUAtXRVQ9KCiK8KnqDlviILmm25NbtfgvmAS4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dlySNfuv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BQv/8RM1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dlySNfuv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BQv/8RM1"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DFTIZp3177142
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TNlVfOVc1/StZ0tejxF/DIFWBXRWATBfirtcnn7at9k=; b=dlySNfuvX1efQkMC
	9+3mRkMFFfE6WwzPlKTE6Zno7r/oRsmgukyCB24fkQ7PChBL0iHJTFY26OhOfJf6
	ZwHMipMX9OV044H3+Ocb6Zc8GPSOwREE1hNiME+RIPWCFOXsoi2yBhkdffJ+KVur
	cBbTkOH4KNQcoZ7hTLlDRywUi22ZG3a6fsUKpM3y0kWkZYr5TWR7d2iYkzq01s/y
	89lMfoBnw1WXxCpdd/NYZFx+hugi8NgRTsSdMISy5uaAYC3PVqv+6lsILh4N7ZH1
	G7K/ZcNnNSxLndzFfJcI2Yqyi467pf/3Q1WYYlaDrDZ8rbRIOTwFOEeoNg0O5cFL
	/vsbzQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1f94h9pg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:43 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1b4d961dso845561cf.1
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 11:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786645063; x=1787249863; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TNlVfOVc1/StZ0tejxF/DIFWBXRWATBfirtcnn7at9k=;
        b=BQv/8RM1ujQRKCy2a1uSRrGf9l2dQDapkaNq2SObtVNXPLDWqlKpLemw2SpxfBlgJz
         t9E0a1nPMbtNZgZ2yO1B0jg7vSgaBxbdSLCElNa6LueneidHKWJOuqkvb5EGolZqrYUF
         kYUlkSUeX/D2HayRPCZ3vUWcs9cR5fZrphzZCnxwptcOSs6VqonKwwf6dZ7w0VI7rw0t
         wRmIfaVXczTZ4TcLORqPb9XO9fiR5fLk+OttIs8queMM7tIjBhJqafz2X3C0hPL2UHVd
         EYoO28+SkCqDoJK+C435RTCFL6LIrEXwlc67iEew44JBDOMrH3Y4KhEGt1Q4Zwj8g224
         s1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786645063; x=1787249863;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TNlVfOVc1/StZ0tejxF/DIFWBXRWATBfirtcnn7at9k=;
        b=EtTR3NHP+ipU3KJE1gQhRZk9Q5ckV2TTO3Qnj/MgV2dxcFcxhoNqA8CjTc+KmJflfa
         FGYppKSUyuJ/5mBK1thNgECdUP2Dx4hypLyScgx+oyhpYRK8Y2ISJHQ94fYP3QFjT0G+
         ae2/9Plkmm3fJnWBYirFFOdXBnHbMWhTN59GslDngCkv0fwzaN44DE7xAGQtZGG7yTpO
         tRBgERGVg8tWjgO3vjD8qZnGTwwwdBtK338YDU59i6u06BDbZBYqGxgBJRDxZj9o9UjT
         bgjWl9paDx+wAGzGhULTYUwa3BvRsRB6C0uhywZM36sQ3cRALKlVqx+qIivd37/doE1O
         X1ZA==
X-Forwarded-Encrypted: i=1; AHgh+RqJmMvGR3aEFKKa7nfyWHr3YqX73JSBbUZvVuiJN3YDmxioiDiZ+QP0Qb4Z5vzIpX2El3w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ZLjgZZD9EgUn6LVojwJORnYjThdo42Pfpl2ywzbeNXjkxhi6
	/AQt0kwLL6gp0WpYbAPassaU+HFdnojXoNssdD78kSc/YusQLG3/VnHYgM7u/xU1J3MvJ/Ggvbh
	Gt/trB0ivwBkEAXbIt0bHogZx6VG1pdhQB+BHhbV3z2d1DJX/hXjInAk=
X-Gm-Gg: AR+sD133+mkl6r9/UHVTZWNpjpp7RVaS6ao/5JtdOdHjC66OTa0Nnagz75FlpezUFoG
	+nsdnyFBqvjZqbLKraHV1tVrP0lSqqwxoHj1pU3SFq7Q8BZRL8ISakSgMPInpkNCQUNBHQ+iUFT
	rEFQdg+NAJ8xMQtrCxMe97TV2vUGT6bZhexM3XrpoDYX+da1WVl3efauwX6la+etDVmERZqZDSE
	ETgX3iMoFh9eLASBPWBImUPSlCVoSA8DEb3zyJiWdGt+pv9zH5JzOeGjliKouuHKUnpzuMfx1Gg
	X8eIblI1Mm1sb0Msa/Neo4gU4VsG+IsnC+ugn60sV55A+tkpThky8In5ezt93wtQIwkm/KfUdt4
	iBPwyVmmMMGhz7ONCMyFWCAaCgwOGTaPcRk5xpb3W4Q==
X-Received: by 2002:ac8:5d53:0:b0:517:c582:9161 with SMTP id d75a77b69052e-52d74a6f672mr72352111cf.7.1786645062892;
        Thu, 13 Aug 2026 11:17:42 -0700 (PDT)
X-Received: by 2002:ac8:5d53:0:b0:517:c582:9161 with SMTP id d75a77b69052e-52d74a6f672mr72351051cf.7.1786645062216;
        Thu, 13 Aug 2026 11:17:42 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4998777ce49sm4934935e9.2.2026.08.13.11.17.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 11:17:41 -0700 (PDT)
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
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
        Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 08/16] cpus: Slightly improve *run_on_cpu() docstrings
Date: Thu, 13 Aug 2026 20:16:31 +0200
Message-ID: <20260813181640.6537-9-philmd@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfXyrp3Ss+NPpW9
 vA1TlKXid56SRRj78Y2s/TZ7nvGCK6OL7LomnrOgYHXuZqh2r6/iCXRZV32NiuTi+00H79I6xj4
 LNnDB1KLVmLAmxv6SbnQ1eqKz2cXK20=
X-Authority-Analysis: v=2.4 cv=VYDH+lp9 c=1 sm=1 tr=0 ts=6a7e0a47 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=dWi2WT42hRTxaHT5buIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: eRvprD7WaqBg1ccGmNyRkVl6deIzVTw1
X-Proofpoint-ORIG-GUID: eRvprD7WaqBg1ccGmNyRkVl6deIzVTw1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfXxUFQ+0bN3RD6
 cp52W/eQx76ECLF7mhBPt7S42Ys57PslCq0XH7kVtEUKOGG3uwsi74isede0jNh9iRInpqQo/tt
 5TGabMTQxCMMChnm/SIBHPTTHEsPYjAmFiv/g2ZKeeUR8OjMOcBg540tod0nRFBQMfwZVqHQr6K
 SDpTWD3i2+IC8aTCdOkuDASnZvwpQnUvCdryG3buIWM9XqhAY7uS0j9Wkz5KEsq5jRegPWcvzeb
 kc8bQqurmBxfxDfn1bUNLVstD4xoSeVXZQhVwnZPr503evAY+PZvDI8YyuVeDUZglmIFfE4SMwC
 AIm9M6kviGd543iSPjh6QEyTsG/Vo6G4SGXEQN3AwsSXjXUR2K1ST6PA2v48dxNo4y6BgFwJI9I
 PuNRXOXwF7sD6i5C2I+zNMX8M5OtVEPiKMEEpuTFyPHVUBnSKfyPUyAtj/4yfZozmuvEsPC1sUq
 fFVprp9ZWXJk5R3rJxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130132

Be a bit more precise mentioning BQL use and blocking calls.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 183ef9f4ef2..d610f87abd3 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -908,36 +908,40 @@ void do_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data,
                    QemuMutex *mutex);
 
 /**
- * run_on_cpu:
+ * run_on_cpu - Execute a function on a vCPU and wait for completion
  * @cpu: The vCPU to run on.
  * @func: The function to be executed.
  * @data: Data to pass to the function.
  *
- * Schedules the function @func for execution on the vCPU @cpu.
+ * Schedules the function @func for execution on the vCPU @cpu and
+ * block until it completes.
+ *
+ * Note: The caller must hold the BQL.
  */
 void run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data);
 
 /**
- * async_run_on_cpu:
- * @cpu: The vCPU to run on.
- * @func: The function to be executed.
- * @data: Data to pass to the function.
- *
- * Schedules the function @func for execution on the vCPU @cpu asynchronously.
- */
-void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data);
-
-/**
- * async_safe_run_on_cpu:
+ * async_run_on_cpu - Queue a function for execution on a vCPU
  * @cpu: The vCPU to run on.
  * @func: The function to be executed.
  * @data: Data to pass to the function.
  *
  * Schedules the function @func for execution on the vCPU @cpu asynchronously,
- * while all other vCPUs are sleeping.
+ * then return immediately without waiting.
  *
- * Unlike run_on_cpu and async_run_on_cpu, the function is run outside the
- * BQL.
+ * Note: The vCPU will hold the BQL when executing @func.
+ */
+void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data);
+
+/**
+ * async_safe_run_on_cpu - Queue a function to run with other vCPUs paused
+ * @cpu: The vCPU to run on.
+ * @func: The function to be executed.
+ * @data: Data to pass to the function.
+ *
+ * Schedules the function @func for execution on the vCPU @cpu asynchronously.
+ * Unlike async_run_on_cpu(), all other vCPUs are paused while @func executes,
+ * ensuring @cpu has exclusive access to shared state.
  */
 void async_safe_run_on_cpu(CPUState *cpu, run_on_cpu_func func, run_on_cpu_data data);
 
-- 
2.53.0

