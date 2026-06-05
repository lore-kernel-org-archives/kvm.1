Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B342E1C4E
	for <kvm@vger.kernel.org>; Fri,  5 Jun 2026 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680103; cv=none; b=PnQ1v2+ApWHc4t3iSfCGZ9IcFuQom2EEhhJ7Y7L5Lt8ucagNe68WcN7IMVxQ6nZdgc5UKGjDT6U/+OhDMITlDI59gDsS9U8vY2APfcAjV5wf87H/fSG7n0/I7jWgfk8LT3hUj4tg/vYJJ5T5Lext6FPxUjDfdAkLmUVBcdHWMk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680103; c=relaxed/simple;
	bh=8tTRwbp9AcvSXwLZ47EatpQBCFtrnQzXwinzGNrdSUQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RnysijtRYAtZ970WydgJevcNZROut6V0yo2W3mmbXnxv0PsBgSwYegqbEVYAoncOfACp2qWqDpbbyfVxs/jgVypVZdhZRzMf3P4lKamqT8TdgFdUj4LcQp2wNJL98iJ4ZeKSj5b0ydf2NQluAYqJCjWzcayhuXp2uiNLqF4q/gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYqDLqpY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYqDLqpY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8E21F00893;
	Fri,  5 Jun 2026 17:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780680102;
	bh=wx6MIxMGQ8ffiHKowvZ8HLnfj8URosmdvI51U9TlZdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PYqDLqpYQ+1rF3gRwXCYR9d5bfdVvYK9FtB0WKpylz2PARCFEHz5aO/HIfrpy98HC
	 oYL05jZX5dXCwe4S7R2Qq33Of1HBSUGzxpRMyHqthPG16kQHjGzC9m/RO7ywRTZbBO
	 7HAIEkmvbv1+CF29mM4ft3uIzso66fM/PitefAkBqZrFpn+EvlSNjnvA/2JsCdNu9E
	 ya5bYedfYNnB0TCmdakT+yhiFAQkxjB5JFW9IbEmGGQpvoip9JxAJLMFKGTEqPpPzt
	 4kVfKz2+UtI3NOIxW4cj8WmtNSXfVePJq6/FXNzal0hYrCptaTTar6+qffi65Fzpqt
	 qwzdTilRJGaRA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 03/10] kvm: Prepare core VM structs and helpers
 for LUO support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20ae20f9d1a198b289444ebb4c824314cbba1bcf.1780676742.git.tarunsahu@google.com>
References: <20ae20f9d1a198b289444ebb4c824314cbba1bcf.1780676742.git.tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 17:21:41 +0000
Message-Id: <20260605172142.1E8E21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing `__rcu` annotation on the `kvm->vm_file` field triggers Spa=
rse warnings.
--

commit aba59ce9475ece27b2837967edea8ac0058bfe79
Author: Tarun Sahu <tarunsahu@google.com>

kvm: Prepare core VM structs and helpers for LUO support

This introduces core infrastructure to support VM preservation with LUO.
It refactors VM file creation into a new helper and tracks a weak
reference to the backing file in struct kvm.

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 4c14aee1fb063..9111a28637aff 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
[ ... ]
> @@ -874,6 +874,18 @@ struct kvm {
>  #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
>  	/* Protected by slots_lock (for writes) and RCU (for reads) */
>  	struct xarray mem_attr_array;
> +#endif
> +#ifdef CONFIG_LIVEUPDATE_GUEST_MEMFD
> +	/*
> +	 * Weak reference to the VFS file backing this KVM instance. Stored
> +	 * without incrementing the file refcount to prevent a circular lifetime
> +	 * dependency (since file->private_data already pins this struct kvm).
> +	 * Used exclusively to resolve the file pointer back from struct kvm.
> +	 *
> +	 * Written/cleared via rcu_assign_pointer() and read locklessly under
> +	 * RCU (e.g. via get_file_active() to prevent ABA races).
> +	 */
> +	struct file *vm_file;

[Severity: Low]
Since this pointer is meant to be read locklessly under RCU and is updated
using rcu_assign_pointer() in kvm_create_vm_file() and kvm_vm_release(),
should it be declared with the __rcu annotation?

Without the __rcu qualifier, static analysis tools like Sparse will trigger
a "different address spaces" warning during the rcu_assign_pointer() call.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1780676742.gi=
t.tarunsahu@google.com?part=3D3
