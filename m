Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD4F17A303
	for <kvm@vger.kernel.org>; Sun, 31 May 2026 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780255817; cv=none; b=BCDiVIP160nHDtr6JM3BYJlRDk1ScYGkATlzkVUcn4btiyPxABGTKngUk1WfoRAbcPl7O0gGprdeclSKcxZCXciqKK+GTdcaycju8fxmnigBFmkHpQc7m18QEeyd5pRKe8nAdEd8iBPN0drIuzT8E61MXVpsIvD06B88AGhgbP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780255817; c=relaxed/simple;
	bh=hyHLA9V/k96PY7BJk8S05AeISdugnQjZl24PLvofo7k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j8IGAnZDZZfx0N6bnQFu6ttcSS5Oo9O+zMA1YdUalqkL/6BTnmhLr8I7BDKDdZ98lleDQfFMQh5/1wDj2M4ZJArrQil1bz4gf3gkzWQ6nNHLf57DCB4yNqcp/0kzji3qITwTrs9uRHY6BujTqz+HY5YIyT4pYAijZhYr4PJCs+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8tT+ZuD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8tT+ZuD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE0C1F00893;
	Sun, 31 May 2026 19:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780255815;
	bh=gHTEOGkugVWXYYFJ0Leoa8FnCVoJybaf7xWyxytkSXY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g8tT+ZuDw5Pxif1eW70lo9gVu3kgpV5ibcSMxk3zhDDEdJ+IAX4lTakqTf6F+mzqK
	 KrtfjCch7hUcw3nZE1MFAmV8NAFS8KjgLTeSSajTPZzVfWfrFK7ayfMXXtSlVxQypk
	 Brhz8g5RTziNj0EI9HTbeAIh//R+6z0Yrh+PwRBo518/9gPzZKFc77MMYZOjRz9W7j
	 h3w+v8Mj86wR6QQFz3uTammhUZgJ2Tfi7t5gfgfh648igF4igIKSKn8TFNRQYlVRNA
	 nNoazE9+w9KADNmX5HRlXj4wH3tlS2Vq3721hrdT+RjGJVWKaOSQXpvgmVB92lTA3Z
	 rZjaYpHU/rROQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 2/3] KVM: s390: Enable adapter_indicators_set to use
 mapped pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Douglas Freimuth" <freimuth@linux.ibm.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260531190353.204317-3-freimuth@linux.ibm.com>
References: <20260531190353.204317-3-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 31 May 2026 19:30:15 +0000
Message-Id: <20260531193015.CAE0C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Missing dirty page tracking in fast path breaks live migration.
- [High] Unprivileged userspace can trigger a host denial of service via WA=
RN_ON_ONCE.
- [Medium] Atomicity of indicator and summary updates is broken if the summ=
ary page fails to pin.
--

commit 30338b81c5f9c19e09c8c31062f7a9c7f3b4ecb4
Author: Douglas Freimuth <freimuth@linux.ibm.com>

KVM: s390: Enable adapter_indicators_set to use mapped pages

This patch optimizes the s390 adapter_indicators_set function to use
long-term mapped pages when available. The fast path operates when interrup=
ts
are disabled, while unmapped pages fall back to the slower local mapping pa=
th.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 5ad0b29c8c1b2..a7cff4289f4ad 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c

[ ... ]

> @@ -2895,41 +2895,80 @@ static unsigned long get_ind_bit(__u64 addr, unsi=
gned long bit_nr, bool swap)
>  static int adapter_indicators_set(struct kvm *kvm,
>  				  struct s390_io_adapter *adapter,
>  				  struct kvm_s390_adapter_int *adapter_int)
>  {

[ ... ]

> +	if (!ind_info) {
> +		spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +		ind_page =3D pin_map_page(kvm, adapter_int->ind_addr, 0);
> +		if (!ind_page)
> +			return -1;
> +		idx =3D srcu_read_lock(&kvm->srcu);
> +		map =3D page_address(ind_page);
> +		bit =3D get_ind_bit(adapter_int->ind_addr,
> +				  adapter_int->ind_offset, adapter->swap);
> +		set_bit(bit, map);
> +		mark_page_dirty(kvm, adapter_int->ind_gaddr >> PAGE_SHIFT);
> +		set_page_dirty_lock(ind_page);
> +		srcu_read_unlock(&kvm->srcu, idx);
>  		unpin_user_page(ind_page);
> +	} else {
> +		map =3D page_address(ind_info->page);
> +		bit =3D get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->=
swap);
> +		set_bit(bit, map);
> +		spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +	}

[Severity: High]
Could the omission of mark_page_dirty() and set_page_dirty_lock() in this
fast path cause a regression during live migration?

Without notifying KVM's dirty page tracking mechanism, the destination VM
might receive stale indicator pages, resulting in lost interrupts and guest
device driver hangs.

> +	spin_lock_irqsave(&adapter->maps_lock, flags);
> +	summary_info =3D get_map_info(adapter, adapter_int->summary_addr);
> +	if (!summary_info) {
> +		spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +		summary_page =3D pin_map_page(kvm, adapter_int->summary_addr, 0);
> +		if (WARN_ON_ONCE(!summary_page))
> +			return -1;

[Severity: High]
Is it safe to use a WARN_ON_ONCE() here? Since summary_addr is a userspace
virtual address provided by the VMM, an unprivileged host process could
intentionally munmap() the memory region to trigger this warning. This crea=
tes
a potential denial of service vector if panic_on_warn is enabled.

[Severity: Medium]
What happens to guest memory consistency if pin_map_page() fails here?

In the original code, both the indicator and summary pages were pinned
and validated before any bits were modified. Now, the indicator page is
modified in the preceding block before the summary page is validated.

If pin_map_page() fails and returns -1, the indicator bit remains permanent=
ly
set in guest memory without the corresponding summary bit being updated,
which breaks the update atomicity.

> +		idx =3D srcu_read_lock(&kvm->srcu);
> +		map =3D page_address(summary_page);
> +		bit =3D get_ind_bit(adapter_int->summary_addr,
> +				  adapter_int->summary_offset, adapter->swap);
> +		summary_set =3D test_and_set_bit(bit, map);
> +		mark_page_dirty(kvm, adapter_int->summary_gaddr >> PAGE_SHIFT);
> +		set_page_dirty_lock(summary_page);
> +		srcu_read_unlock(&kvm->srcu, idx);
> +		unpin_user_page(summary_page);
> +	} else {
> +		map =3D page_address(summary_info->page);
> +		bit =3D get_ind_bit(summary_info->addr, adapter_int->summary_offset,
> +				  adapter->swap);
> +		summary_set =3D test_and_set_bit(bit, map);
> +		spin_unlock_irqrestore(&adapter->maps_lock, flags);
>  	}

[Severity: High]
Similar to the indicator fast path above, shouldn't this summary page fast =
path
also update KVM's dirty page tracking? Modifying guest memory without calli=
ng
mark_page_dirty() could corrupt migration state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260531190353.2043=
17-1-freimuth@linux.ibm.com?part=3D2
