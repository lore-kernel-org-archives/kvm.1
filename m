Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54994353A9D
	for <kvm@vger.kernel.org>; Tue, 28 Jul 2026 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237669; cv=none; b=Xze9fRgF8juBKzJ91ziaOdbD0L70pf6o2KHk6E+ESFkV+mqxcur7yogBF+cmPyVhAN2W/bby9GJJ52mkmsm6rA4Djxn8aFLrM/ZBCul9xGZnq3gJsrAw4JVpPuv3sFIwpWV7t2uFGQuqxFPyeM07JY1PCdxSIKLSF8kJD/JbMoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237669; c=relaxed/simple;
	bh=4+dIUJSnEYQYNZxhECDfGi6c1UoxqlEzMRNlAAgG4UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFqRxU08BMCdmHv9kBhY0M1PSuajY5/44chei0DI0WF87h0DyTFZaxrI4Cj0jsAgVQrktn89HyPllZw+igwJaGhfFOmCXPh2qJT4FnM4HjlzM0bLzerMlRwZsR8T6H775Yo2M4gSP16CKseI9te0jYzJRIqersnG0yVvJcTQ1RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cs8I++fp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cs8I++fp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4031F000E9;
	Tue, 28 Jul 2026 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785237661;
	bh=tMmthg5QOwk/FUXaXgk/6L7Fh6QZ5tRAI7epZh6STjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cs8I++fp+QyWQn6MvZa/IFmUpxSlRWOpIjNyPxnhgd6xrKyMJC+C/f6mqniHyaAPD
	 R6Ziqi28s/xfDKGE9kBpMw1T8dZcAff7t8r6/ZvX+LgSpBA7Qjw/3nbB9zWaXKfJdS
	 3UEiQbAMhl3Qx82xtgekAe+jqOu348xm+H2IpTLzxRZaO7iv2+vd7UUZ3gOlEZQGfA
	 spKgnQ2xvQUdhZXI0JkFmbEzoW+lLM/8npqP6SoeT7lHXPnn7WObyxXeZ3NKpHeewj
	 4At8XyXC7VmeS45wm9DufLnU67iOXrgldg7sZm6FxOAGhEwybBGiDtJaPtWmUTgGxh
	 Hao2MWx19ZBjw==
Date: Tue, 28 Jul 2026 13:20:56 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
	berrange@redhat.com, armbru@redhat.com, pankaj.gupta@amd.com,
	isaku.yamahata@intel.com, xiaoyao.li@intel.com,
	chao.p.peng@linux.intel.com, david@kernel.org, ashish.kalra@amd.com,
	ackerleytng@google.com
Subject: Re: [PATCH RFC 10/12] accel/kvm: Don't default to private attributes
 for in-place conversion
Message-ID: <amiQmARN-r2RSaax@lpieralisi>
References: <20260528000416.8161-1-michael.roth@amd.com>
 <20260528000416.8161-11-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528000416.8161-11-michael.roth@amd.com>

On Wed, May 27, 2026 at 07:03:35PM -0500, Michael Roth wrote:
> Without in-place conversion, QEMU can still access shared memory to load
> initial state into guest memory prior to launch even if the GPA's memory
> attributes default to private, since userspace is accessing a completely
> separate pool of memory. With in-place conversion, all these accesses
> would need to first be converted to shared, then back to private, since
> the memory all comes from guest_memfd and only shared memory can be
> accessed by userspace.
> 
> To avoid sprinkling these differences in behavior throughout QEMU when
> in-place conversion is enabled, just default to shared. This does not
> compromise guest security, since Confidential VMs will necessarily
> enforce this via trusted entities, and simply generate implicit page
> state changes if their default expectations don't match KVM's. However,
> in most cases a guest will explicitly convert memory to a particular
> state before actually using it, so even these implicit conversion
> requests should be rare.

I assume you want to prevent peppering code with convert-in-place
conditional paths where, if we default to private, certain mem copies
to guest memory would fault.

Flip side: we default to shared, we leave the current code paths unchanged
(that assume double backing) but we end up (eg on CCA) populating guest memory
twice, once with a copy to shared guest memfd memory (that is basically
useless because populating in CCA is destructive) and then populating
the guest memory region using CCA KVM interface (KVM_ARM_RMI_POPULATE).

I am just thinking aloud and sharing what I have noticed so far.

Lorenzo

> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>  accel/kvm/kvm-all.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index fd01435a0f..c3d399517d 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1808,7 +1808,26 @@ static void kvm_set_phys_mem(KVMMemoryListener *kml,
>              abort();
>          }
>  
> -        if (memory_region_has_guest_memfd(mr)) {
> +        /*
> +         * Without in-place conversion, QEMU can still access shared memory
> +         * to load initial state into guest memory prior to launch even if
> +         * the GPA's memory attributes default to private, since userspace
> +         * is accessing a completely separate pool of memory. With in-place
> +         * conversion, all these accesses would need to first be converted
> +         * to shared, then back to private, since the memory all comes from
> +         * guest_memfd and only shared memory can be accessed by userspace.
> +         *
> +         * To avoid sprinkling these differences in behavior throughout QEMU
> +         * when in-place conversion is enabled, just default to shared. This
> +         * does not compromise guest security, since Confidential VMs will
> +         * necessarily enforce this via trusted entities, and simply generate
> +         * implicit page state changes if their default expectations don't
> +         * match KVM's. However, in most cases a guest will explicitly
> +         * convert memory to a particular state before actually using it, so
> +         * even these implicit conversion requests should be rare.
> +         */
> +        if (memory_region_has_guest_memfd(mr) &&
> +            !(current_machine->cgs && current_machine->cgs->convert_in_place)) {
>              err = kvm_set_memory_attributes_private(start_addr, slot_size);
>              if (err) {
>                  error_report("%s: failed to set memory attribute private: %s",
> -- 
> 2.43.0
> 
