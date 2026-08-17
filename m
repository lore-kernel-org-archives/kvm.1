Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339E33AEB39
	for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952009; cv=none; b=a3VVf7UmujDOcidPxMeRg6ZGQx4ImGrrKX3dH/QIMgHrqMY5i9W0r2O78kMfRDUBPFPW8JDrYXzgZBRCsQJLb6hnQZI5yj7egRZOWUc09IRMETFncVxXO2FgKUEz+qMFO8Wmr+cOKm5v0m63tvxMMYSf0ttPcOYQJ9SuDdPGzDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952009; c=relaxed/simple;
	bh=tM0pTha1/9nfcltCgNGuo/8gpha3J9wIDaj3gZsBSBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=V93NAHP4UDrYOsSZ3t8WJ4x/QOg/AXpyQqUy5V5zgKDSygAwAwLWe+E96HLcIz9fru02FyNVe/l6shIihBwqy2wMOv38EiE4zgMZ+Jgc+RFKz16raoI6MOPQ0odeLQmPiFqEbTZsqzdojaucLQj3pitdlbLsG+TDcYjU//98PXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=kRPYtlGp; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="kRPYtlGp"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9aea40d799so1685830a12.0
        for <kvm@vger.kernel.org>; Mon, 17 Aug 2026 00:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1786952007; x=1787556807; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ctO/918wY9I8dgMN/rNhQAZPgaBP/6EBpuY/G7CkCVE=;
        b=kRPYtlGp6tjDZO1MoOKwooRhe9o+y77qwcwF+6aR1wNLqQ9Wrehxsh5PiQMu2KWEg6
         z8RkNRDrZf2G+/ujyyaBfuAjjMZmV2qluBkP6kbvZ+wzWpYySyeOUu1AjH6eLUC0MN+I
         lTufIYkgF+iALfcuWL7KZXLL5vIwxqWIV1LTsXwILPlGXgZ9eC2NW3zovUWoBIoZ5K47
         0MRo07D2gfamrBRXwynGF8xR4uWpn5T1tjVmbqlrEe7oAGnjCrYWT3uf+xT9oWoW7JEo
         k7jL4sVHcnvoWeVSqLi5/6LkaXsZ6gntW1s1d+Sew5ovojzqqb2FN9Q/1kVJ1Ll4m6as
         svIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786952007; x=1787556807;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ctO/918wY9I8dgMN/rNhQAZPgaBP/6EBpuY/G7CkCVE=;
        b=jFrZqB89NTv4usUw+IUecmgrco+AEUlV/oQcxL0Qw7Is0BEbc7rcq32TaLKoNekV18
         zFNXTlAvaOHUYzCYyhgX5uYqnFWximSLbDSa6S6HwRlaQOBvQ1fDYD3upHu3/WKk+FKM
         l28VTXQUxfnu+51KgVkbSqIWF5QM775bnSFZv6IeQZK5BOgNycMmdyOAfDU5QjNt0bYn
         z4aYAYNh/hUC506dEDP0VR6UOpCNr9PkSOpyX38yrt/nglDLEsDRrJVnCpwtddvCeLi4
         nuiiVAVWuO3eeIyp3dJGRIgwXJr0i6n2eAuSbycl7IigF8Y7z8SObo7xPIlXQ7mRFe7R
         ggNw==
X-Forwarded-Encrypted: i=1; AHgh+RoJT6bqMh45ZnGwkx+abdk5gv97lj4JCPS1BOULsBfmxkQh+7py0bNsRNeDoIikhSTtO2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YztV0Y3+nkShvMvPbfs1wn9Ybn+T6fEUv8ovY8RMNDvXDTbUnji
	yrgH6nKmr58fcLhFSibXTkk8RzgZUnDEn5uEC/TqL/3REm/hDM31jVF9dzM6mEzE9qQ=
X-Gm-Gg: AR+sD105F5yxthkFapwcNnnkXUHNEMc7kt9s59dNmoXSGKiGSX6nsH0wvjhfy5fVQN9
	mRColOrNM/Eefi5CJwHNiUnlW9fCR6Lr+ndO9NUzkFaF2CLMEYtAIhzE4Bi0qIhHpHptPrHsk1Y
	/hFbFTEGwJOv8GKkD0QAcUyiw9uxLADYH4WGPuBxn4pTC0gzIHafWilEkqmI77Eke+R+nJqCwV2
	qXgxo3pH7czrur2qo+n8nQW/zM+De5nUsARskX/jmP46rYpM8uRYwdZGcbMPtvHtOblHZ2gKZB9
	79+86xjzx8M66iGJRivxCOvIK9+d6cKxK+5yxwzFmi8dTGarBA+pXMZ7wrzVacnmt75MFBw33QN
	4y+jUGibrW9fgeRnqAj23bx+tddb7L101jv8CnE8tQKMrC+gf6asI9rSR8OlF+bEnbwZa4MCSSl
	9pYx1zYOa9jvI+GvAc40sMKbTlBEPpRsLFzANyWvAjd4PbwaTQqcCVHlIicvfx88tjrL4hx+/FJ
	DbYD+Xl
X-Received: by 2002:a05:6a21:7702:b0:3b3:d0f:7883 with SMTP id adf61e73a8af0-3cc7196eda5mr27885097637.7.1786952007506;
        Mon, 17 Aug 2026 00:33:27 -0700 (PDT)
Received: from sw07.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-326796d646bsm3575972eec.10.2026.08.17.00.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 00:33:26 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Date: Mon, 17 Aug 2026 00:32:59 -0700
Subject: [PATCH] KVM: RISC-V: Clear HSTATUS.HU on hypervisor initialization
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-hstatus_hu-v1-1-28c53cdfb408@sifive.com>
X-B4-Tracking: v=1; b=H4sIACq5gmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0Nz3YziksSS0uL4jFLdRMNEC4tEI/Nk8yRDJaCGgqLUtMwKsGHRsRB
 +cWlSVmpyCcgEpdpaANvzj4duAAAA
X-Change-ID: 20260817-hstatus_hu-a1a88a27c7b1
To: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: greentime.hu@sifive.com, vincent.chen@sifive.com, zong.li@sifive.com, 
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Yong-Xuan Wang <yongxuan.wang@sifive.com>, 
 Samuel Holland <samuel.holland@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786952006; l=1212;
 i=yongxuan.wang@sifive.com; s=20260424; h=from:subject:message-id;
 bh=tM0pTha1/9nfcltCgNGuo/8gpha3J9wIDaj3gZsBSBo=;
 b=xzAemguTvxKYZkrL488xqh1xU5+sYfHiXmghrUUa42oEqlIaC+MMhYmzECXbY6IRHF230q1PA
 xRvrYY3gIRDCL/W3d8Js+WjMQhGkDGoZJqmExKFef81IWvX/6NJVnCE
X-Developer-Key: i=yongxuan.wang@sifive.com; a=ed25519;
 pk=+8NCHB1ZJvZthQAmZspOAaqjo+/snaW8mFSiDx45HxY=

The RISC-V privileged specification does not mandate HSTATUS reset
values, leaving the HU bit potentially set after hardware reset.
When HU=1, hypervisor instructions (HLV/HLVX/HSV) can execute in
U-mode to access guest memory, which may cause unintended behavior
if not explicitly controlled.

Clear HSTATUS.HU during KVM initialization to ensure hypervisor
instructions are only available in HS-mode, preventing unexpected
guest memory access from U-mode code.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Samuel Holland <samuel.holland@sifive.com>
---
 arch/riscv/kvm/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kvm/main.c b/arch/riscv/kvm/main.c
index 85e772588fad..e80a99e93d56 100644
--- a/arch/riscv/kvm/main.c
+++ b/arch/riscv/kvm/main.c
@@ -47,6 +47,9 @@ static void kvm_riscv_csr_init(void)
 	csr_write(CSR_HCOUNTEREN, 0x02);
 
 	csr_write(CSR_HVIP, 0);
+
+	/* clear HSTATUS.HU */
+	csr_clear(CSR_HSTATUS, HSTATUS_HU);
 }
 
 /* Clear hypervisor CSRs - called during CPU offline and non-retention idle entry */

---
base-commit: b5060a4aa33d7d78a8c1837ab08ef0c81ea96650
change-id: 20260817-hstatus_hu-a1a88a27c7b1

