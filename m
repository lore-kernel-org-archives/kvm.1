Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C3E3515DC
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786645080; cv=none; b=RR/8prPkb16pZtnDMMeA23PpLhSM1EBFMhRP+0hGoXbskaOKSuIIlv/XZQifTH380DIfxFfdWKq97EvSyEWtFhbgRDBMSkkvNCRP7s7XpRN+xM7bojv6E6BCqmVJIaToUhlp+nbM3t+/5cqrnD671wfMG/DISJoD/UkhFae6zDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786645080; c=relaxed/simple;
	bh=/Ocw4hCrh8px7w7ABXYhCY4nB3VB82KCxc72zh13moY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DAXtqpKYdJOSXdkZHJhtCVEzvtYUByCOAKEw05ruOfpI5tRMaSRuyy3BggMnXzpQ6RcJhLwGITUAuHt09TMqPSVx9L3pluaC0FvD9QwLIzlzetW//AhMrpd941kH6WT698IG01H9P+aiiJlkutLyiw8Ut4doCZtvLo4qEodnpHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W2IloqFS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=c6UF1B1i; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W2IloqFS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c6UF1B1i"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DFqsjk3180701
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8agxJTIsSpKLfDGc1usrfc1YNaxVZOAKA/A8ADkj078=; b=W2IloqFSb1jzcQUA
	hzNfC++VvnGkvXpFWcFo+lwZ81M2zW0z/z4hTdmgBqJGQu5jf/GqRsdwlDGFMR7c
	+4+VolF0RCI4s9wW5sgkHeNMpAss6Hd8s5Q4V2enuDqYqblKrhaOUKOaO1hvrmd/
	6PNjhPnQAFo2PnK4qktqYzPx+yYDO9zk6lCum6AdlgwCfEf91ichE7b5tVfEms20
	IIKMbzrlnOmofR9RZIS9nseeb4kSBW9B3IRdg5MNTaXfkoIU89TcxWPE9BV5ci2f
	8H2a4ftDokNQPm681wb6YJVzPzTWvDKb99oiN+d2fLTaCIdr7zuHQXBckVPe1NeQ
	znsdDQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1gy4rnx1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 18:17:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c26012cd0so2358261cf.0
        for <kvm@vger.kernel.org>; Thu, 13 Aug 2026 11:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786645077; x=1787249877; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8agxJTIsSpKLfDGc1usrfc1YNaxVZOAKA/A8ADkj078=;
        b=c6UF1B1iNgeb3qDX47UOjDUNkEUbUk1GpnRYeGgJylWhDChzGJ37OvOagEwwveBzrr
         we62iBtTnl+vGrenakrsb8nLmsYBz23oLJ+kZflFy5L51Gmqsm5ZbW3OgrH1kEeEXUss
         iYuftF+suNGjIcWv065mJbs1rjheFxyL+0tU86X/q38K1YJV6/A3nJMgvlSomiVBJEjS
         fgwsSvBmXSHKqP/F48nwqpbY5RRwR7PuMFR0nbjTW7otj5b05iwoBCVc6ZPQdwgqPzo4
         ic5P0coxiAhFDhb7cP8F4dRbWt3MLy6nyWTZxrJ9Xn/tPp3Lhjn1bMkOKqxTnabhzf3b
         +Ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786645077; x=1787249877;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8agxJTIsSpKLfDGc1usrfc1YNaxVZOAKA/A8ADkj078=;
        b=UxchGGm0o9e32eSwmFH04uFuhkZyWh4OJoGiSLoxWHf/K5ptaTPWCXkKGp+GKRAdSi
         oGSBRAerDE7ISzr7Usda5AKlzhNQ4jtbiTHWlEIGu3BUMa9q/bSwcYXgf+jj1vrsRZrI
         B5YnytHYHlPcYOVicQMmuKTVYJxrCs5vtDiUZ1oLcFQhiIsP+ulbxY6Kvn7B7eUycqWA
         +ds7cTcsSoGNZYp9jZx0h9bcYV/uZxNYEtNNKJn1J8pyfmQmUiu7lfvQqQ/eH7XSYf55
         2ZaxjfhIP4TKpLWLGY1D6cgxp+8ThS/q0CyI+43/dqntTPlclyOs0P329xT77Djksq59
         oNnw==
X-Forwarded-Encrypted: i=1; AHgh+RoX8Yfo6YMY6q/U8+HBR/doDFKVpr9ZDtwZUmNhwQ3Vymn3YqyB1PDHVeUAmCW78+vCxWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2M4HtQEOSeNOWVZPbBZu2Z+RodWmhcXvwuaQA51CiPR4jiQcs
	UYZAkgQSjLALstOku7T0yCoLhAPjnD9iPXYjZJcEhrAQXLjgfk570pDCi+CN2st1pxIAQrf13+E
	lEAy8rFSWQk/35nlXOtVS4VxAVzoHdFU9gFNB5E+U7u5L0bA36m4zbvZ088jxka0=
X-Gm-Gg: AR+sD11IHk+sqHkN0TC8dDPLTwPADlkZAv7koLhxdfS/HbZCwJYVK43RqGf4l6DfYJb
	JFRJnTCcJ5doNJrciNy0zh5OiTmA4+aM6PZyc6h5E3FbmaXXNSJEiJ2rwMe0UfPHeTQwk8PLzPK
	bIvBRIdKRxLeB2zEdi9cCF0tU1QPv6hAcycdk3FpiZjbH8nE7P0zgcRpfCD3rz6nkQ71+X2XoSr
	d/ds/rBjfw6meB5KeuKuXZBaN0sPBaRBXiainVi1Zaa61g/jNMLEjooClH/prPy1sfglCQBP0ng
	mnb+V8ij+soq34DT5SAHCFwC4V8hYGm1IKaX3qKGO2264/qnbkwHVE/ML+3k3Te85MEDkTjtUX9
	/6bJkZY05N5dJntvcGeRb5KO9JzPjBvPetjtk+q2JCA==
X-Received: by 2002:ac8:7f89:0:b0:51b:ecbb:206f with SMTP id d75a77b69052e-52d73de0b68mr77220671cf.32.1786645077011;
        Thu, 13 Aug 2026 11:17:57 -0700 (PDT)
X-Received: by 2002:ac8:7f89:0:b0:51b:ecbb:206f with SMTP id d75a77b69052e-52d73de0b68mr77220031cf.32.1786645076558;
        Thu, 13 Aug 2026 11:17:56 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4998777cd05sm5859245e9.2.2026.08.13.11.17.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 11:17:55 -0700 (PDT)
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
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 10/16] accel/kvm: Clarify use of @r variable in vcpu thread loop
Date: Thu, 13 Aug 2026 20:16:33 +0200
Message-ID: <20260813181640.6537-11-philmd@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: Nt1d9eOrAU4K8slV0kGQqKtZL-nucc2C
X-Authority-Analysis: v=2.4 cv=ZYAt8MVA c=1 sm=1 tr=0 ts=6a7e0a55 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=9RVOebA3_GiVrJoGtMwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfXwvpvyqXmV+Ex
 t5v+caX97AoYioxExLM1neyE2telKQKeASv3hHnQWggi4HCuaOWy6wS/F6QQaGn3BQLTe03QdcT
 SQQrGrJhpO54/bHVHpeDq7v2HlYbbyI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEzMiBTYWx0ZWRfX+vrp17cBha2P
 bFuoZgu/b+sWaQo9QabgdBWgIr/WSmaqcp9SEg0aDbF7C+nxSo7N/ach0peOsGLrhZRWs2IB4p3
 JTvv1lu/fVtLrKMAqgriz97tLINIP1JiCSk1sucexocZGqPUbJGuNa3NCfOwuKFSQiHPPH7ujYE
 U74Jy8QyecXmgxDK+XVDs9aDhJ1NSlv44JucbYemLP/gGrjKwxhBtYB4PhtEvUQq4ArFA6QRYmF
 RAiS0ryFLua5KNkbuuJguWiw1jY3gLvHymyjT7Ttm4XYuii8Koj2poGpc7bn/Wms8C//vcMNn7x
 K1f+J8oWOX1045t2MCiPycyUvgOxHFrMecpUbqATbuLfma9zM1vM73UVKj4GPF75zpxGDJ12l5U
 kVTjzbPHzUKKnng6rUbceEkXDGIHRascoWrOF90lCwLSJYAbNupph4p/JPQ3ayiPfGnDNtwiAfZ
 /6mNit/Rxx98SzKMt+Q==
X-Proofpoint-GUID: Nt1d9eOrAU4K8slV0kGQqKtZL-nucc2C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130132

@r is used for 2 distinct concepts:

- kvm_init_vcpu() returns an errno. However we don't consume
  it, besides it is called with &error_fatal. Drop the
  unused returned value.

- kvm_cpu_exec() returns an exception code. Reduce the variable
  scope and rename @r as @excp to clarify.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 accel/kvm/kvm-accel-ops.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index 73ff93aab67..06f56773324 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -31,7 +31,6 @@
 static void *kvm_vcpu_thread_fn(void *arg)
 {
     CPUState *cpu = arg;
-    int r;
 
     rcu_register_thread();
 
@@ -40,7 +39,7 @@ static void *kvm_vcpu_thread_fn(void *arg)
     cpu->thread_id = qemu_get_thread_id();
     current_cpu = cpu;
 
-    r = kvm_init_vcpu(cpu, &error_fatal);
+    kvm_init_vcpu(cpu, &error_fatal);
     kvm_init_cpu_signals(cpu);
 
     /* signal CPU creation */
@@ -52,8 +51,10 @@ static void *kvm_vcpu_thread_fn(void *arg)
         qemu_process_cpu_events(cpu);
 
         if (cpu_can_run(cpu)) {
-            r = kvm_cpu_exec(cpu);
-            if (r == EXCP_DEBUG) {
+            int excp;
+
+            excp = kvm_cpu_exec(cpu);
+            if (excp == EXCP_DEBUG) {
                 cpu_handle_guest_debug(cpu);
             }
         }
-- 
2.53.0

