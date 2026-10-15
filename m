Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FE04D0A1F
	for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 08:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052421; cv=none; b=MJ9r3XINKY1w/PtT7w9dX4QOseXmi34sCBA3VUdGdSOdwSLezk6mCEwRQwJjnF3TLcNmSnxMB9PJ11ir6J2e+zOQ3PAqqFJcWfWLM2dT4s20KKfmjJ60Xq4GQUgmnl3KjkWNnjmRZUanfIN8EjF4Y8r6uCW5RVraJCLoLVxf38o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052421; c=relaxed/simple;
	bh=KVOZ2lLgrzuWZgZSB9rwBDkQhvmCwD1PiXcl7UDJl0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beht3opHjSfg6qt6//Y29+MSFIbYzteaqK5wDm/vv5npisOmTPo6xHlpnj79so3UQzEe8SjabMx/XurrrXqXTl2sfxiu+VRqDAGyr9VstQP4l1aWpBpzUZ0mqJTwPC9WYpN+hxD7Y7biEhXwurh5CJnNWNzgvBq27Q1iqdEoKTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYlnVwTR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYlnVwTR"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso16277765e9.2
        for <kvm@vger.kernel.org>; Thu, 15 Oct 2026 01:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792052418; x=1792657218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dGPhNShpJ5TEx2EGucqMdtalYIrKk9jaQj19DVUtNbM=;
        b=GYlnVwTRNXFc7A7xiu3fSpYFhXISvaNhuvyIeBJ1WfCxJxxa+CmiphFqgx1MpPQLH2
         ctC+PtQBwNuXms35ZmEtQdcs8AxDN61JAfY/tmJuYU8VTh4PFjUnSz3dzR3XaPverm0D
         W/ZZQZswtSRU4d1P4ucuidDfvFe+3mKbQbrqRui3yWUghQPxredD9EbEX/EqaZIcuKtL
         /ZsPBQmZnuk5M6DFAHKJilFzqo+vYmUDSTXmU06UJQnFFcVag8i0b8g3aXK2JYOyi7UJ
         oDsbfJJAmq8nOMChSXCtAKnpOrRE1hFVbLVtclGCHNrnWpInTzZaPcg/yLa2zS+daXvK
         29/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792052418; x=1792657218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dGPhNShpJ5TEx2EGucqMdtalYIrKk9jaQj19DVUtNbM=;
        b=N5s8HkkiQJDShF2c3MO9C19nsN0hYV7AUha0RMSBC2H4l4jmOR1Q/LO8dvO4dqhNcw
         yqD+49faO5zvOfuHfxxECVhz8ntXH8qBHAj+Ll+3ULxgfELuuJ/rVOmEEg9Rr3q0NQ8y
         Ln+QNiE3DuIKDUNyFG48D9vGy3XdLt8NKzpLNdpCwPvd647NTxK6BIidvyUNjwNXq09k
         uxkEsaY/Qttx4+Eaz98/sbIcxyQR9QwvqiTG7u1eK0wYYnJk4UJVim5be2loICJOSxqg
         0K4ZdZ4G+IQeiwRGriXJHOmIG/6nxHMJyVDQwr53wusiZjejBIfLF+4P8BwvsP8c2gvf
         oAIg==
X-Forwarded-Encrypted: i=1; AKwUvBxo0ttQOEup5+BUzF1s+ACah+wq84dCzHnEcRcMUs0RD/CU2sxLm39R6sOiiTlKqyb6tT8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnqpOiP4PQODcE8RDHobK8Gxju5jDvt/22LC4SDaXqb+YZQPLq
	Md5mOJ87TpZe7eQ5Fr1WYR5CIDwV1RfC2FigW8IqJlYgB6FYOoh77b+/
X-Gm-Gg: AYBFou2EMOqFeZMuYQIs0zxv7TyTDRaaK0HBw8CpA1Zf0h4lnjIZFEnq1/CJHBnnid1
	Y7ULm2fzzxhSp1E44pUUcdqk7TQ7RYd+/9d0A+2q2emFDNsObOcOz2ChCuQ2ALSvqHHOD7Ya1T0
	B6Y0PutkckDLS0ZM81F8oabkdVqeP02pBlv9ijSQAuzvYPDR7+0LVm9fRppEKvYQL9LPVzA1pzJ
	kBJ3PK9lDdZJf7uxaYp2Bzbqwz9Wb36Yxh7C7SQZJy31AZrGSAUFmJWqI9X5e0xpnKbQezUIkg5
	e4xIHobm38y5RbFhbl2qju11D7gBPgjEoYuuvMkGXJWD2v9FNi4HhgnUgk4y/3btDuve1a4MBa8
	Xoninp03FZZqOQ3a1Mrhr7Pva0ZW6bMSiApB9XKyAsUknZjM8qfQlHVRpSDIge8Igj9mkbV0pNU
	J6LIvTpUoZrdTyGDc9jnhU93naTyAXBeofO5j+0bkqsz0v2PsYIUR7sS0e9PRbLm46C+RC6eur1
	ctnub3HfWY+WoVgUNtpQHEkNdBJkctHFP/g0ZiI1Mp/6A==
X-Received: by 2002:a05:600c:83c7:b0:4a1:7733:5102 with SMTP id 5b1f17b1804b1-4a18e4a3fc8mr349752215e9.15.1792052417094;
        Thu, 15 Oct 2026 01:20:17 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.109.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd9b35a6sm49003545e9.6.2026.10.15.01.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 01:20:16 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jiaqi Yan <jiaqiyan@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] vfio/nvgrace-gpu: Drop the usemem length check in open_device
Date: Thu, 15 Oct 2026 10:19:35 +0200
Message-ID: <20261015081937.405320-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015081937.405320-1-parri.andrea@gmail.com>
References: <20261015081937.405320-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvgrace_gpu_open_device() sets up the fake BAR registers and remap_lock
only when usemem.memlength is nonzero.  The check exists for fallback
mode, which used to share this open path.  Fallback mode now has its own
open_device, so only devices with ACPI memory properties reach this one.

For those devices usemem.memlength is never zero: an empty region from
nvgrace_gpu_fetch_memory_property() selects fallback mode, and probe
fails when nvgrace_gpu_init_nvdev_struct() rounds usemem down to
nothing.  Do the setup unconditionally.

Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
v2: New patch

 drivers/vfio/pci/nvgrace-gpu/main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index 208463c218088..8dc792b4fe7ac 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -185,10 +185,8 @@ static int nvgrace_gpu_open_device(struct vfio_device *core_vdev)
 	if (ret)
 		return ret;
 
-	if (nvdev->usemem.memlength) {
-		nvgrace_gpu_init_fake_bar_emu_regs(core_vdev);
-		mutex_init(&nvdev->remap_lock);
-	}
+	nvgrace_gpu_init_fake_bar_emu_regs(core_vdev);
+	mutex_init(&nvdev->remap_lock);
 
 	/*
 	 * GPU readiness is checked by reading the BAR0 registers.
-- 
2.53.0

