Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75623DDB18
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847880; cv=none; b=Yqx34c0WcZ5P9Uu38wqPDqGZGeh8ZuufiHUw8hxwvPpvvVPic/TFg/r66TdKnDouLhnnnxxE9RzbLBIuiPD9GGWU319mBUoxyuROXx5w7lxhfjpnXMz1OcLYVi1NzOYIkrRyLb/zHHXjqcooZbAcQqwMzGaW7NIpYOOshraCxEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847880; c=relaxed/simple;
	bh=p3m5GXW9//sqcToEGrOhZJTZ6LjBM2VvT/Y79TrH+cs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vF9Lr8putzKhgUlZ9cWiVb5pNhnliKoE0DSLcf2GKiQ4EYN38RwPD7Mpt76/nRnBGD++CSut+1w/8aVVdWnHeuH58+kJmPYfQ73gB5ym7gWj3aCODl/3Jh6rb/B9CZt4vkSlBwaJRebeOUoerTF1P0zMf51R3u/tvuUOxLbejXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/ClB/BV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/ClB/BV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20491F000E9;
	Tue,  4 Aug 2026 12:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785847870;
	bh=fnr1u/ZPJ49cNYzEMXcQdxw91I1g9au5AseCYnnV12w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e/ClB/BVJwrNsw9CU/N4h+pJEX4m4qbrfcAnWOZBn4GjjfbBdc42SwwQRiR6QsdeC
	 v51vuSQSQCQtUeInynEOmT9grx4N1kZFymUcSwEaR92TCx/WBg9+47h2yqSWJNWyNl
	 Bx92IsTvRqdgZ+EqwxEo5kyfMYBTOr9kGJblKqNXNwxdo0+vsbjjRx1GNAa4d1n6Nq
	 p/dKX+jxi3oTpHwJhUC8li2BEl1pV7ebaRf36NIy1sTnXUvUz4BTpqSS02mk2hML5I
	 6mVdlTqCoilU1SDGD7AmbbDeiztoEjWCtaxaXPe0w8/DSQNiFXDQsxS0+iUHK84Eo6
	 v06a88C90U1XQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KVM: x86: Protect virtualization-enable VM walks with
 RCU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qi Zhang" <marsy12010123@gmail.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260804123243.2213854-1-marsy12010123@gmail.com>
References: <20260804123243.2213854-1-marsy12010123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 12:51:09 +0000
Message-Id: <20260804125109.B20491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data race on `vcpu->arch.tsc_offset_adjustment` during CPU hotplug=
 can lead to guest timekeeping corruption.
--

--- Patch [1]: [PATCH] KVM: x86: Protect virtualization-enable VM walks wit=
h RCU ---
commit ff5afc2b0cb8750aad6e3a35f5b08c17dc92aca8
Author: Chengfeng Ye <nicoyip.dev@gmail.com>

KVM: x86: Protect virtualization-enable VM walks with RCU

This commit protects the vm_list walks in kvm_arch_enable_virtualization_cp=
u()
with RCU. It publishes and removes VMs using RCU list operations to prevent
use-after-free bugs during CPU hotplug concurrent with VM teardown.

Cc: stable@vger.kernel.org

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index afcac1042947a..fb1c14d7dc4b4 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
[ ... ]
> @@ -13192,7 +13193,7 @@ int kvm_arch_enable_virtualization_cpu(void)
>  	 */
>  	if (backwards_tsc) {
>  		u64 delta_cyc =3D max_tsc - local_tsc;
> -		list_for_each_entry(kvm, &vm_list, vm_list) {
> +		list_for_each_entry_rcu(kvm, &vm_list, vm_list) {
>  			kvm->arch.backwards_tsc_observed =3D true;
>  			kvm_for_each_vcpu(i, vcpu, kvm) {
>  				vcpu->arch.tsc_offset_adjustment +=3D delta_cyc;

[Severity: High]
This is a pre-existing issue, but can this lockless addition race with a
concurrent kvm_arch_vcpu_load() on a running VM?

During CPU hotplug, the hotplug thread iterates over all vCPUs and modifies
tsc_offset_adjustment here locklessly. Concurrently, if the VM is scheduled
on another active CPU, kvm_arch_vcpu_load() could read and clear
vcpu->arch.tsc_offset_adjustment to 0.

Could this data race result in a lost or corrupted TSC adjustment,
potentially warping the guest's timekeeping?

>  			}
>  		}
> =20
>  	}
> +	rcu_read_unlock();
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804123243.2213=
854-1-marsy12010123@gmail.com?part=3D1
