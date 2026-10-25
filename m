Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792960234;
	b=JSDtrQy8JRUeu3P3Jks+eGl0k8m+nuzvhXKjl4cNJ5R5hovl+iiGa2lYbbzj2xSPqGHb
	 Er+U/CZIDBb10ErY3WusvmwbsOOVrZbZ30cAOIrGYMZDlXIpyd60XIoZSQ9tgDoZTCsVh
	 1z1Hjq5EqOmRJ21MwM/uoxpNMgfdn6x8J1kFAh6f3h+yYT4KFgv5RiNlr6UmIYO5I+iih
	 Kyad1zSzOdDVADOCY3Nn3MBq17PR6zcy0zCnOt7MQF7Ah1qQYb4lxXhPqWzkoiJU2S77/
	 ruFB+nWntovSuBM6mxXI+gOWnQfNm4ZBSNDmbsXjbbPVfLC2jEItrVUym6uTT3DtVRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792960234;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=xhfm/FnI3dgYatG4alzCY4CMRbBwFdv1fIdjJsOp9rQ=;
	b=X4QH/rCWciTHTEUJt/HABiCQ+dqFfGtj7HWysknTbFpNXv4blZJoVLe/Nh1SULXz8S5w
	 p5g2bE44peL/hYL1fqk3zrosFNCm+XkZl+Y6EdtXRlnC+6uOsMVbD4RzkYsoyKHYSpe0e
	 3pgM1PQzw6rGxTrUQqjOCbyxy4B9WaKW8rTcbhhaK9aEdLvvw/A/Qc+SCcwOH+utOJ2ex
	 qLs2k7IZWnKeJa33G7yJkbUNtrz7yKNGQ9tkJwhe1pGvfSZQOyKY8rh01rWVOUzP5Ril0
	 Gh6dbsk061XI3r+zN+0SmImFsvVFrZ96QF1+v15DoOq/i001xKyVnmmuOuwaD3bdOcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="hDS/99aC";
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E817A606A31D
	for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 20:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E817A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hDS/99aC
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso10540605e9.0
        for <kvm@vger.kernel.org>; Sun, 25 Oct 2026 13:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792960232; x=1793565032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xhfm/FnI3dgYatG4alzCY4CMRbBwFdv1fIdjJsOp9rQ=;
        b=hDS/99aCeF7CJxsoTTpZ0+zronkwQywQHbjg0mGFpMqPy+P33plzbb03DSSh3yWcFE
         XdokAJchxaBwkz1TGf7v1Gs0AnodKhKfLIPwCMU/jCH/+DUiIpraVT7SZv3j1rnWdIZ+
         CWKSD7mo/0UxzGlOMn8LKZtslmb/kPKp1WGmrz8q2kjdCkJgANiCoAjh1iK5k9MJXUdB
         ReeG6l/aUIsPWkG4MRK1QRz2l4gspNxWA2cEf5A7Mn/2ViokXWssTASVkm6mYDVm4giP
         uVDtfai7MqPXeUsoS/ww2h35N8E8p/6jY49tQGi6mPliQE/8W1aCSdPnV4V29mt8S4pP
         IjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792960232; x=1793565032;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xhfm/FnI3dgYatG4alzCY4CMRbBwFdv1fIdjJsOp9rQ=;
        b=wRd/33O5gQvlQaJdX5JlLltLjIjI69lVyufnaouR+iFTOuDDFenjcEmYBl159JPv7G
         VW+E+7YT/B5UtVdjxnlte/8OM60L3d7FrxgJq5rQcttURNcEjKW5iXsjHCqED93MA84B
         QKL8QAWVRmUiabp/LV7T/SHjBGrI/0Cb+JTzH+4WiXIHt67OelWNmRjYmbY0t5RdPlib
         6/Xs1pVDH5xsXPfpQSid1bACMmLNulLoamrrdtSSqecp6W2+2WaY7iZzfnNMYrdoHHul
         wzCvQGUUn/orF34OAFYKdPwfETIo3dQliqvJXfsD0OfO131SGS7I0utx/lt0iadGQ+pf
         fqnA==
X-Forwarded-Encrypted: i=1; AKwUvByanStGlVItFIiQtiVwoPxhLuFZ2CyXEH/jJHKwkN7ZKzhEN9PZrS9QjKKJaAj9IXAySoY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyutsKjbjVT5pjofSzw9MiR/mLm58N2/4nbyd9NyPxg5woyL4l
	Tx8fxtsdLwVFwIjupBSCEwvMY28ykFwQfqDenbP23dxNpIe0h6CgKyEt
X-Gm-Gg: AYBFou1i78XRkQiGmE+rIxkzmbTc7usgbKPIRFc2kBT6yXjZltmjMvgrAZvXCy+mZAs
	VIVYMwfOSdYuXWl8zg/OHwWnfGIkNzGn8NGtDUigJE7oh/ZhyQb3rqtZnigdfteV26wx8MIfGHO
	j4fUMuCPro2pJP+k55qKM2T8HHz4oE2mmBKBY8VSEC+MAfFj4JOhiu77pfbMnI3JfZGpo/wDIdh
	4Cq8PxQ9D5Gz1PDtHLDl/KpZRjaM/Bium3+gxYLaLq4ymYZyvuQiXvlhRl+stoFEiKpR/sDJJMF
	5/2VU9e2ZNE9rIWQm6+I8ypWkoLBcgloR2z3AzbfhzvB3Y86PE00U1EowjT55C7N9qOO30zyzGK
	FT+IVia3n/ZXQdFc1I+8bUWG/JrdfMF0mD4peo9CXKlP15cuMB/bpDJHCA24U6XxIwwDCw92zA+
	6yVh8hKxX4tDqKSu8F+kMn8kMkyMbgOIFNSFQtf7keHF1cCfWwMdAaOMBnZKUHr6T0Rx5EYYtfh
	j8MGpQSoG/06SyJpv9p0VF30dtQBqeaEzWvzAQjRbR2h2kSnCB2S5ugqR4/oM6C2yBnXbFL3s33
	HhTjG9zGRJktCEjYyR9Xzq69m3VunfRGfdluv5UMbHkGje21CVEBUmPwbLAhYR2FTSpvbicYXmG
	8FSbyifjhrwb14wkic1psOS2A1ZUlhmAZESDx5wvqPQXho1S9B1sFFdfkEkTF1cwbMw8IBTQX31
	5j
X-Received: by 2002:a05:600c:4583:b0:4a1:825a:56fd with SMTP id 5b1f17b1804b1-4a35acc2773mr98426965e9.32.1792960232061;
        Sun, 25 Oct 2026 13:30:32 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a9cc-4401-09c3-9199-30c4-c6a3.310.pool.telefonica.de. [2a02:3100:a9cc:4401:9c3:9199:30c4:c6a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3cfasm12003158f8f.17.2026.10.25.13.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 13:30:31 -0700 (PDT)
Date: Sun, 25 Oct 2026 21:30:29 +0100
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Oliver Upton <oupton@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Eric Auger <eric.auger@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Shuah Khan <shuah@kernel.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] KVM: arm64: Preserve level IRQ re-pending
Message-ID: <at5k-_Ign30fPuHE@gmail.com>
References: <20261022064628.4206-1-kmehltretter@gmail.com>
 <atxWfRsNNK8vdeSr@kernel.org>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atxWfRsNNK8vdeSr@kernel.org>

On Fri, Oct 23, 2026 at 11:55:57PM +0100, Oliver Upton wrote:
> > The exact alternative is to stop and synchronize the target vCPU
> > before applying such a write, as the active-state accessors do. Is the
> > conservative replay acceptable here, or should ISPENDR pay that
> > synchronization cost?
> 
> Yes, just kick the target vCPU out and sync the LRs back into the VGIC
> state. That's consistent with the approach we're taking everywhere else
> where this sort of issue arises.
> 
> If we're lucky the vCPU is just poking at its own redistributor and the
> synchronization is free.

That makes sense. In my current v2, vgic_mmio_write_spending() uses
vgic_access_active_prepare() and vgic_access_active_finish() under
config_lock, and drops the extra struct vgic_irq flag.

> 
> > The issue was reproduced with Zephyr, NuttX and RT-Thread guests. On a
> > Raspberry Pi 400 host with a GIC-400, each GICv2 guest handled the SPI
> > once before the fix and twice afterwards.
> 
> Have you configured these guests in such a way to reproduce the issue?
> What exactly are they doing that is susceptible to this issue?
> 

Yes, the runs used a small test harness in each guest. Each test
configures unused SPI 150 as level-sensitive, pends it from thread
context, and pends it once more from the ISR before deactivation:

- Zephyr (qemu_cortex_a53): k_irq_set_pending() -> GICD_ISPENDR.
- NuttX (qemu-armv8a): up_set_irq_type(IRQ_HIGH_LEVEL) and
  up_trigger_irq() -> GICD_ISPENDR.
- RT-Thread (qemu-virt64-aarch64, pic.gicv2_eoimode=1):
  rt_pic_irq_set_state_raw() -> GICD_ISPENDR.

A driver that hits the same pattern is RT-Thread's
components/drivers/mailbox/mailbox-pic.c, which amp.dtsi configures with
level-high SPIs and rings via GICD_ISPENDR. 

pic_mbox_isr() reads MAILBOX_ISTATE once at entry and clears only those
bits at exit.

Sending on another channel while pic_mbox_isr() is active sets the new
MAILBOX_ISTATE bit and writes GICD_ISPENDR. Without this RFC fix,
deactivation drops the second pending state on both GICv2 and GICv3 and
leaves the new channel bit stuck.

Thanks,
Karl
