Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E1B2D837C
	for <kvm@vger.kernel.org>; Thu,  2 Jul 2026 07:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975826; cv=none; b=A33Trq9BAyvfp8zDFcFRX7RlmtPhx3Rc6x7SZTou5lbx51fQ3IG30iVmlCfz7RQ4IjSt3ljfe4GtfvydCYH0PCZvt+ZqjNRJaYbfK4tEWgQMFu8O18RJa2HObognDJexer2nPB/UshbV7BuYARSiG4mR+oPtynJf2rrZgMX/rdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975826; c=relaxed/simple;
	bh=G31s4HpEd+BVQ6tovNlNHC2GFeqjS/+qowVXSsZOcL8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=pnZPXMtWFSeuxj/1ZJMXXJ1/7VHJvbjrioigdIEm/5BZTQFCVpgzCNpONtReoB5eOOZU3N5dZ54c0k68zaSCFMgjn5+0/4J9rgFGesoJE10ddim1uXb2w+uFo7G24W9SakYF+llcCYKDc4xhcuC0E/glEY3dadbeqISuWoAk2Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THwSshau; arc=none smtp.client-ip=74.125.227.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THwSshau"
Received: by mail-pj2-f3.google.com with SMTP id d9443c01a7336-2ca26c5dfcdso3080705ad.0
        for <kvm@vger.kernel.org>; Thu, 02 Jul 2026 00:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782975824; x=1783580624; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SyvGLflMKxj5TJj0MbBJrl+6Uj8IG1b8yKVmm5bW71o=;
        b=THwSshauwWjfaY18ZIs9PgnG8Rk32OAE5liA1IH9HMzl/5FVCUMRByV6ihzDhkqRVy
         OnXwrPASGNYLIfgfEMlnwAtGyZJTocIU2O8uLS74MC0nh5pnmPId4GoS0dcCOtBEo9iS
         dPYxs6ohQFPBgO/twnChrzjg3F5lIiZ75TUzkfdSUcjwlNQNQyAPQx0bIkNBsDBXB5wE
         Pce8Rsfj7IBj3lrxJ4LPWD3nch1Y6Aens9vwU9AcvsHACQWs0aiPRLSBQcwghcQgz9nC
         iuwMMLyStCTxk6fJA7QlyfLH57b+dpnbWq9yclkR7vT+pUA1wU8THA5QcwmEIrZdjTyj
         Npng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782975824; x=1783580624;
        h=content-transfer-encoding:subject:from:cc:to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyvGLflMKxj5TJj0MbBJrl+6Uj8IG1b8yKVmm5bW71o=;
        b=EXlBhli1zyTrRPl/swQN/HxDh2y8vew027CdddnNwHLXhcr8emHIH/VZCi1n7CMS2b
         RtZDwn7MrmWKp2MUr0+EhhLEPLYD+Ko2Sh7cNan67KVFQrbD0ysNKyonznkI+blBGQ5R
         vos4+ZTG+mJ01CEkpadVvtrwR9mMQU3X1ReJJmwbx3BojZhujq2/ZiTX0B7R9AqpN1u3
         CLm2rn/mfH/ap7exFdAHEMq2P76Tl8w+VX2o6qUgC1SXKjDuvSIcRIFVOH54ALbrVtgS
         /wcRfW6evsYWjLThlVIePyLgy3Q+epfFEKj9/U9jfzU7u2FMrFDROp7giCCtxhhIFLr+
         5CSg==
X-Gm-Message-State: AOJu0YwIfAlAigGb9sDbdCBRL78oRtsy2nf76NYUfyxMmz8bP7dXVbKm
	S9xySV8Fvrp4/cZvhMX9+jEHkg2hQh3DR0/I4XHZOPIXdyvhIRR2P72nWKGC8SYp6SsUeQ==
X-Gm-Gg: AfdE7cnIKdy64mOdZ5hGq+pmT090Jx6Ihrfb/4w4FTl68NXE9CTifmZ+hKAIA0cHDea
	DjflSMFfDm+VRlRLuDIgG3GcAr3gGoe3Re0wgYFBetZwHY98OQQEMTL1jFVdRbqJ712MqKTNB+6
	vN6/CMXCaWQ8hn4oBU/3bXGUQt624tjkF86oC7jUX6T1cdgddHAAq786lxf7XlFJD12JrbwYa98
	sI0nBQbIzHJq5SGt6YOgOEXcP4CmAeAZ2rt77kQb6kwwlLluPh/BT3GvQHp/tFwOO8RFfROo6MV
	HOD2+psDYP8qBEXl+urAFQrXgWFe46ipUy0FR25Tdd45XVuDdbVgryW1a+XOtQgclDZy/nwAjZw
	y+/mZHyafNEM7N2AksK/PKZ8fK5sDrav5SGjI9zEv5cyii4O8LrXP2gutLMwyhgEGahF+tsiUvj
	QH9ONwW8ZchjONk3+tYi8vRRNt1exPwtrTSeHCKYHj5tsd7SBHE2PznhQg2mOpeBtDCRTiEg/ii
	hEIAP1me/iEr0WJCgofpBbIH+gX+oQ=
X-Received: by 2002:a17:90b:4c92:b0:36a:8254:8eb1 with SMTP id 98e67ed59e1d1-380aa0bbbb8mr4181629a91.6.1782975824091;
        Thu, 02 Jul 2026 00:03:44 -0700 (PDT)
Received: from [127.0.0.1] ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380e17ce28dsm545933a91.14.2026.07.02.00.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 00:03:43 -0700 (PDT)
Message-ID: <010b3966-8c8c-4f19-8135-a1041d5f97d6@gmail.com>
Date: Thu, 2 Jul 2026 15:03:45 +0800
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com, seanjc@google.com
From: sundayjiang <jianghaotian.sunday@gmail.com>
Subject: [PATCH] KVM: TDX: Use check_shl_overflow() for nr_pages validation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

 From 4be3dcf1fca4acd2bf9c22bd604c913ba1774035 Mon Sep 17 00:00:00 2001
From: Haotian Jiang <jianghaotian.sunday@gmail.com>
Date: Thu, 2 Jul 2026 14:13:27 +0800
Subject: [PATCH] KVM: TDX: Use check_shl_overflow() for nr_pages validation

The nr_pages field in struct kvm_tdx_init_mem_region is a u64 that comes
directly from userspace via copy_from_user().  The current validation
uses a manual overflow check:

     region.gpa + (region.nr_pages << PAGE_SHIFT) <= region.gpa

When nr_pages >= 2^52, the shift (nr_pages << PAGE_SHIFT) wraps around
to a small value, bypassing the wrap check.  While downstream protections
(gfn_to_memslot() returning NULL for GFNs outside any memslot, and
kvm_slot_has_gmem() checking for NULL) prevent any actual out-of-bounds
access, the overflow itself is a real bug that should be caught at the
validation layer.

Replace the manual overflow check with check_shl_overflow() and
check_add_overflow() to correctly detect the wrap-around, and use the
computed end_gpa for the subsequent vt_is_tdx_private_gpa() check to
avoid redundant and potentially overflowing arithmetic.

Signed-off-by: Haotian Jiang <jianghaotian.sunday@gmail.com>
---
  arch/x86/kvm/vmx/tdx.c | 10 ++++++++--
  1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 989ab29b8c6f..9c6aa95ea1e1 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -3234,14 +3234,20 @@ static int tdx_vcpu_init_mem_region(struct 
kvm_vcpu *vcpu, struct kvm_tdx_cmd *c
      if (cmd->flags & ~KVM_TDX_MEASURE_MEMORY_REGION)
          return -EINVAL;

+    u64 nr_bytes, end_gpa;
+
      if (copy_from_user(&region, u64_to_user_ptr(cmd->data), 
sizeof(region)))
          return -EFAULT;

+    if (check_shl_overflow(region.nr_pages, PAGE_SHIFT, &nr_bytes) ||
+        check_add_overflow(region.gpa, nr_bytes, &end_gpa))
+        return -EINVAL;
+
      if (!PAGE_ALIGNED(region.source_addr) || !PAGE_ALIGNED(region.gpa) ||
          !region.nr_pages ||
-        region.gpa + (region.nr_pages << PAGE_SHIFT) <= region.gpa ||
+        end_gpa <= region.gpa ||
          !vt_is_tdx_private_gpa(kvm, region.gpa) ||
-        !vt_is_tdx_private_gpa(kvm, region.gpa + (region.nr_pages << 
PAGE_SHIFT) - 1))
+        !vt_is_tdx_private_gpa(kvm, end_gpa - 1))
          return -EINVAL;

      ret = 0;
-- 
2.34.1


