Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3374234D916
	for <kvm@vger.kernel.org>; Mon,  3 Aug 2026 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796208; cv=pass; b=aJRkzBcMl0jqDHDh1+PPi5Hs/iyNTPmOaTmB7iB2+qrRe7JZMYLtEFR5NDr/jLT7m8yPvEYkM+Gc1FkEe+F92qBeHpyz8VoAz1BFdwC2HGObc4noAyfxmJLo18IfRqIzrRlyqfkBv1Lx7gw/sddZhXb4/x9Kk6H6kYNX8uieGAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796208; c=relaxed/simple;
	bh=SoGWMfuDZcITvarO1qukl7KE+ls5azooLD7ZNrSHGPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ox/uJVHhNgT+bWz7pfQU6HxNePTJHbe8Hd9rJ4Wikz1BrpwDT6ydlMjCUmDFi7efpO5F+1Qp1k253QpHDlbGZQ0bj0sKrgjq4sJtAEIc17ZMSQeFa8NQfO51eaEODFSbd3M3bYNc2D3FgRUoeS2MEIimfHsOGBNi82RT5lJsP74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZHcQziAs; arc=pass smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZHcQziAs"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e57a753f9so290429585a.2
        for <kvm@vger.kernel.org>; Mon, 03 Aug 2026 15:30:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785796206; cv=none;
        d=google.com; s=arc-20260327;
        b=RlC+qmEP10p61tYtMiRtcmj9Q0n+WWmzYxPEuEoAaZSTX4ELnItgIZiIvAkvI9J02f
         Jz3NaVVNkhCDBKeDC/KhVebvLyUv+MRrj3WZhw73RXHJrbpFC1Nh9AUK9D6O6Nx8/gaR
         wMvwjF17eo9i3dDwqQEijTrX5DpRGyvJcGETVO7xK83xyXKlVrzAhurk4VWTeVnIRo9A
         7SNK52stk4EaGLqf9Y2k9Sjy1yOvX6mme/XM3CTzINwEYbnZNUE54fpS+Ql7MdqJF+gI
         L7f6jwG+fJ3DdOwik1pcLNfQlyj0uC/mQnvXPp8MaxMXOaK0ish3cDxHtn9YZW8NK0y3
         yhTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3yTl9Y/o436Zlv2Vup2MQ3FRSTw8xGxoHxInk9rGis4=;
        fh=BRtUdATIegm+BEo+jnt2w+2sDYRV+XDAnWUbwRUv4xg=;
        b=TUSbUJRQglEr+gf/lD42ytXuQxVT5wpxfzuTi5ikPQRo8dhTa1zZU60cUXEjTa8DWV
         7I+Tg2nKrM3nY6NTA0tzkGQwvKcwZ478qudsX3eRqSivqBu/8rGmfSPS5K++aHlmPLAH
         uB/g9mWhe/Je8Z08H/gMKKFpUaZQ5+++A0cQq3RNruQauytVWCIU/DLdcxgKWquR5DIq
         2CxtSgiml5J60AmNUv9Mywu8LTzPo799ywWQylrVrFBVf1bm9L7t0WXPywsMfK041wCR
         h7kT4zqLAKBakkXAsHc/Yiau3ilHDXE1RU5hhKgbE+vqIE0uNif7N7kXuIyM+vCNNiJ8
         dYEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785796206; x=1786401006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3yTl9Y/o436Zlv2Vup2MQ3FRSTw8xGxoHxInk9rGis4=;
        b=ZHcQziAsPpJ3g0c3it/71c2BORIUp7rJ8isVH2r4Fg+/rDzDHV37b9/i1Qpic8XaZA
         KlwMUUBJaauZqoOH7U2msKuRTVrI5cmoXJ7cSvn+SA4Ns/IUMAhTdfqI6PVe03/MBmw3
         HYG7xpX6B+FPpEdalQ5hBm56r213FxkjYKj5Jsy8T7xn55SFQhPpo3d/sZBNsv8QTgPB
         IA3VVRbcxT62Z/3ImPGFrMcDPEaOXh0TYw0B0ErMdD5e1WQVqqLe2PWZph+d/4UlmmYn
         ifjrrRzkl7WmAHcC/36GkQIjfPRN3k3rKhclIu3mOUzNN21/Z/A5FdViKK55SrE6AQRh
         ZEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785796206; x=1786401006;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3yTl9Y/o436Zlv2Vup2MQ3FRSTw8xGxoHxInk9rGis4=;
        b=L1ri73vZpT7KkeMiklySM6khy19wPn4G/ErK1/RYwr/6/Bl9MQulacrpuKWC0fXIxm
         jbEwjmOlwX53lgFB1qP5pl2v72trio++Fz/w26NgdbIVetKtY60R189uM3Uhh60+oNEA
         /npC+aLcibuM2gCt2Wmz637tnLwCHFyXIxTua698OIWL4bm3K/3RNCcX9wUa/V65eItl
         X7x/aI91Rw6NQyTpECsFuDECWD83vnYlBu2XObfF2q29TrZXZg6DiSP0xgQxnfoizXRp
         efvoLGmEtNNXNlmlyu8OJeC0MpG2cfww49Zf6saWvWD+ZO+1XPSHrNHC0bOssF310fu7
         xzDQ==
X-Gm-Message-State: AOJu0YxLSWAPpeePXLLf68i0lYl5W3bCVj74KOM+NakY7w5FrmiK9fKc
	UKKwSq7HhGdg1WG5glU4M5KCSRxvG/z988NMMhvmaqmkSmCMbrKhuoEkfNmWQoIe9bvCqim4wVX
	DzL11s78e5csIlnptt78c9pY7SPslfy2W+FXL2BVB
X-Gm-Gg: AR+sD13RaHYZwlTLB7Ee2EP4O5HNrgVJLmsbQ3qECfQGOyMKKN6Ro8jSHvFzEfjGnBW
	SYT6K4fd9ixLphqYA/kc0RnJSc/5jtvUaoDXTdS1UP4klBClL+NS4HKM+J/w2RXvJJqt0u7ztub
	fVFyn7fF4TntJ6SJKNDrGWxjz1a07+lZoczhs/wpKgWjhQ0rLZIeMk7TQ/5nxQgrKjZdbdL7Cqb
	vEW8Af/4LwtGrT8z1YqiRbD/E3uFS4Ce8VYhIay2KviGTLU/dMMNH+GTuerDw6yckh5URQVQt66
	FWnq/iDvhIctbfjDf9Iv8o33ZgDHIkOU2taZkKWTptGHOsdA+cFDYtT59sp28XFq0kKfyRe2IGF
	iRQ==
X-Received: by 2002:a05:620a:1788:b0:932:d92c:1604 with SMTP id
 af79cd13be357-934a093ee41mr1858091985a.23.1785796205213; Mon, 03 Aug 2026
 15:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803134403.80630-1-steven.price@arm.com> <20260803134403.80630-18-steven.price@arm.com>
In-Reply-To: <20260803134403.80630-18-steven.price@arm.com>
From: Alper Gun <alpergun@google.com>
Date: Mon, 3 Aug 2026 15:29:53 -0700
X-Gm-Features: AUfX_mzgu7kD5xmIyUYZ_YnVZsQj0adTFpMJoMddiEH4UKglz6_2Lo8CDB6wxAY
Message-ID: <CABpDEun3NPr7Na85pmOvdfYQ1DB-2nCcocsyDESXM15bzJU1og@mail.gmail.com>
Subject: Re: [PATCH v16 17/45] KVM: arm64: CCA: Tear down RTTs
To: Steven Price <steven.price@arm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	James Morse <james.morse@arm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Joey Gouly <joey.gouly@arm.com>, Alexandru Elisei <alexandru.elisei@arm.com>, 
	Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>, linux-coco@lists.linux.dev, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, Gavin Shan <gshan@redhat.com>, 
	Shanker Donthineni <sdonthineni@nvidia.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, 
	Emi Kisanuki <fj0570is@fujitsu.com>, Vishal Annapurve <vannapurve@google.com>, WeiLin.Chang@arm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 6:45=E2=80=AFAM Steven Price <steven.price@arm.com> =
wrote:
> [...]
> +static void realm_unmap_stage2(struct kvm *kvm)
> +{
> +       struct realm *realm =3D &kvm->arch.realm;
> +
> +       lockdep_assert_held(&kvm->arch.config_lock);
> +
> +       if (realm->stage2_unmapped)
> +               return;
> +
> +       write_lock(&kvm->mmu_lock);
> +       kvm_stage2_unmap_range(&kvm->arch.mmu, 0,
> +                              BIT(realm->ia_bits - 1), true);
> +       write_unlock(&kvm->mmu_lock);
> +
> +       realm->stage2_unmapped =3D true;
> +}
> +
> +int kvm_realm_teardown_stage2(struct kvm *kvm)
> +{
> +       lockdep_assert_held(&kvm->arch.config_lock);
> +
> +       realm_unmap_stage2(kvm);
> +       return realm_destroy_rtts(kvm);
> +}

Hi Steven,

I noticed a warning in dmesg when destroying a realm:

  [  158.533495] Call trace:
  [  158.535927]  kvm_destroy_realm+0x208/0x218
  [  158.540356]  kvm_arch_destroy_vm+0xc8/0xd8
  [  158.544439]  kvm_put_kvm+0x324/0x4b0
  [  158.548002]  kvm_vm_stats_release+0x1c/0x38

I traced this and found the following:

At this point, calling realm_destroy_rtts() may fail destroying the RTTs
because RECs are still active and the Realm is not terminated, but the
walk finishes and still sets realm->rtts_destroyed =3D true.

Later, kvm_destroy_realm() calls rmi_realm_terminate() and then calls
realm_destroy_rtts(kvm) again. But because realm->rtts_destroyed is already
set to true, it exits early without tearing down the RTTs.

Consequently, rmi_realm_destroy() is invoked while the RTT tables still
exist in RMM, which fails and triggers WARN_ON(rmi_realm_destroy).

The fix I used was to remove realm_destroy_rtts() from
kvm_realm_teardown_stage2():
--- a/arch/arm64/kvm/rmi.c
+++ b/arch/arm64/kvm/rmi.c
@@ -434,7 +434,7 @@ int kvm_realm_teardown_stage2(struct kvm *kvm)
  lockdep_assert_held(&kvm->arch.config_lock);

  realm_unmap_stage2(kvm);
- return realm_destroy_rtts(kvm);
+ return 0;
 }

I think we don't need RTT destruction here as it will be handled cleanly in
kvm_destroy_realm() later.

Thanks,
Alper
