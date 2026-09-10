Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BE04AA1D5
	for <kvm@vger.kernel.org>; Thu, 10 Sep 2026 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058366; cv=none; b=n8bo94tUuSzhLpoFC5avzZ1Ajd5tehDPoSojOEOaN5qQCSas53qJjsYKX2feg5cwS8B5gO9ht8QLuo40G2P/2TKgICyopRBVmrKspP3dcFY9XE4Ezw+xb8Xj2kwEE30qrJQDv66V/jQZ+ZsE6rH22CAnEy+YKOxzac/riYDOUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058366; c=relaxed/simple;
	bh=QHg1I0gCEGJS928tReZCq2rBEr/c+wfPdEk7Ytl0Pv4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c9YI6sRqFrwaJm995yMjjKNzbLORO3lSRghvPgrIhbvrpdXzfvmyjKYpRhMqDV/Uj9/oK8p8bNDoiHpDGwmuCH2aBt9LTXH/y0+XfqQcQe0X7Rtz7s0RgW6WrxpwbKTM08zu0AC54IEK2oyxdeCppVb4n5O17kZrlEU9D/jB+Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgbZiGVL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgbZiGVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4339C1F000FF;
	Thu, 10 Sep 2026 16:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789058363;
	bh=Nn29dckseSn3y/WG/5IG8ZSDtUgYofhnab485gAq6ug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cgbZiGVLNoqHLbbI4dfevdWrT6lg8phMlNfrOFVU7C+ejKXlRUZt4Kv6jUDbbd00t
	 3kIpNNKYK4QMGcih0pWjiYT47FgePINB6IKvR96xNQhPrE7AnfeizvYSC6ycaiozbW
	 Y9Pad8SBKaXEUdyKP5SMFMlyY1yk33iMTA2yu1BJ1JlmmIqdNaT2ujNjhgRC81Pfsu
	 eyNpoeT7WmJRam2yj+NYn2Esp+XKkPWw956gZ1k0TP+mPkJufTdbu5wFHbZgB8DAhp
	 VZH3w/sQZT0MOBKvXnfWOmCMwKkfZ+GKW24F/FRrjBaPCupIxT7TmCJDovhZqQJELA
	 DaySZo1pQ9SZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 02/10] KVM: Allow reading memslots while holding
 slots_arch_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marco Elver" <elver@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260910162343.4092060-3-elver@google.com>
References: <20260910162343.4092060-1-elver@google.com>
 <20260910162343.4092060-3-elver@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 16:39:22 +0000
Message-Id: <20260910163923.4339C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The lockdep condition incorrectly allows reading memslots with o=
nly slots_arch_lock, bypassing SRCU protection and exposing a data race on =
slots->generation.
--

commit b005b5fdc7c30e96c15ac0330a0485909dc26ee9
Author: Marco Elver <elver@google.com>

KVM: Allow reading memslots while holding slots_arch_lock

The commit adds a lockdep exception to allow reading memslots with only
slots_arch_lock held. It states that holding either slots_lock or
slots_arch_lock guarantees memslots cannot be modified concurrently.

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 03bfc92864b6e..5ed8260ef01f3 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1089,6 +1089,7 @@ static inline struct kvm_memslots *__kvm_memslots(s=
truct kvm *kvm, int as_id)
>  	as_id =3D array_index_nospec(as_id, KVM_MAX_NR_ADDRESS_SPACES);
>  	return srcu_dereference_check(kvm->memslots[as_id], &kvm->srcu,
>  			lockdep_is_held(&kvm->slots_lock) ||
> +			lockdep_is_held(&kvm->slots_arch_lock) ||
                        ^^^^^^^^
[Severity: Medium]
Does holding slots_arch_lock safely guarantee the memslots cannot be
modified concurrently?

The commit message states "Holding either lock guarantees that memslots
cannot be concurrently modified," however in kvm_swap_active_memslots() in
virt/kvm/kvm_main.c, slots_arch_lock is explicitly released before
slots->generation is mutated:

virt/kvm/kvm_main.c:kvm_swap_active_memslots() {
    ...
	rcu_assign_pointer(kvm->memslots[as_id], slots);
	spin_unlock(&kvm->mn_invalidate_lock);

	/*
	 * Acquired in kvm_set_memslot. Must be released before synchronize
	 * SRCU below in order to avoid deadlock with another thread
	 * acquiring the slots_arch_lock in an srcu critical section.
	 */
	mutex_unlock(&kvm->slots_arch_lock);

	synchronize_srcu_expedited(&kvm->srcu);
    ...
	slots->generation =3D gen;
}

If a reader uses this new lockdep exception in __kvm_memslots() to read the
memslots structure (and specifically slots->generation) relying solely on
slots_arch_lock, won't that reader race with this plain write, bypassing
SRCU protection entirely?

>  			!refcount_read(&kvm->users_count));
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910162343.4092=
060-1-elver@google.com?part=3D2
