Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F36509EFB
	for <kvm@vger.kernel.org>; Wed,  9 Sep 2026 23:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788997309; cv=none; b=Jg9pCZZ7CFYYrMHALLfA8qUM/wI3q43Aso4ZKlxESR0qMyDHnEpUle02UFuclqidoN7sxop6DrVtdTWpxwht5wpJENljJGXnWJ5w40P0eO0+hTKMUIkOinu+1wTAYlNm65HhnVox7U8I9zwF4ODvwwme8a5sA/rq0iOXY4HzICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788997309; c=relaxed/simple;
	bh=9JRPa6NgDyKW/+vNH4CfJVZQHHEA+YhbOImOBxwNbQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRBiDGT37fZUPsKwRAgzpksAmRK4ltuxyJKP9aBlHauNSv+o9upCNWCS3R13pli9Sg1qbGJ+Za6NqUqINxyrn+JgOmeIkQdp6AmoGPpxtc9Omp/zKQK22O13CvAwcd/V7r005RirtEsdMsET+XZRotsuAOhSlGe7QFvfxeY19dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ii6xhzbu; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ii6xhzbu"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-939adff838bso280171985a.0
        for <kvm@vger.kernel.org>; Wed, 09 Sep 2026 16:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1788997307; x=1789602107; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/7IOpadrhcRwpRxbqmeGZRwsgZAI2r5KwJqdOCsAZ4E=;
        b=Ii6xhzbuLaNAOCOWQod5okkZHzGosSY8WlF77GOP7KViwryJKdWkwq5qz0/ESjogtK
         8lMJgZnhv+Ix1eQ2fv+PTKnZHUmuG1ccxjawTCZBBhr7VUbkGicvYfTaLoxMFwvjCdFR
         83jLzaCrUfXDdImxbPQgqfbT6oZMUueJnhBNMUC2ISsmnuofzwYY8mGZs+V2szbbJmF9
         sBe7cyhBgKbYOKieHIzA/4JYji8fqO5OC8gALLP5/pg1If9Zf8hf/ouVMa9aGefWv4nq
         TiAWl3+ytCLwEFuIB9fDqL6YkA7F+iHJInn8/lJAsQ5wFwD0DEHmmHkJvgfTe5KvbHLI
         Ws1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788997307; x=1789602107;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/7IOpadrhcRwpRxbqmeGZRwsgZAI2r5KwJqdOCsAZ4E=;
        b=e5N3osW5gzS7ndzodsGf8zbxiq2n/jMg0aZa86TlG1Mz9lCKpiOab29i06hZlh2wQ9
         6ZsHtyY2J7Vn4g+7rNRbUU3BRJxRYV54t5hFaOKP0j877/mUH4mulvuuYVCTTGVdmhxH
         E47Px7hV009IfuFPNXqfzSZvh9F2XommrYKd4jEs1M5bfXPvaR26Yzs6SzMH+9/hJjx0
         +kXrqoSlwFZQel5MjrDU469CC2ORDsxoRZXXib7jiuGNAVx1C4zsN3dsgOIm0B5sMZ3e
         2vKtOVVoXWSNQmnsfufABySbrsthgS4Qz26hbeZvcTmHQV9t32Kssv9ZZSHHICCjdxJF
         nKfg==
X-Forwarded-Encrypted: i=1; AKwUvBy7ux7Q3k6LjseRH87psULWy7smNaVB1IQLYXWtU+/rIb36LNKMXHk29T8wSOwCDE6GpA8=@vger.kernel.org
X-Gm-Message-State: AFuF++kJ3UQ5LpCQK9Ruk2RuKmngF/y83naVox26KJYubRrH5cgWc7wc
	Y4JQv5Md9pKSdhabrou9rI8Tfq9b9npzjCeCwPu7J86Q3dyN1SpwZsUWwagZKbovu0M=
X-Gm-Gg: AYBFou2tmPCR84+HEBTi6AiSqKZutfWUDXlaMWYQUgKCkSIbDSjOrsAfQM8Rr7jqkIh
	yReQ6MUAqmXdeddPEMxedS0y7ixr1LKok0TGmzWhz5QITyfkdE5wOhFNTDlNn4i7Ylud+F3SioW
	awLbWruZmZZgGdDvN09iPZE/E84pon4LWKBKoiwAUedz8rtfunOEvc5ORTzz81WcxQXT0XL4U8K
	168PnJoDHTZ0BR4q4dVrztVkrIMPRZe/ULWDmP0b4lFT9jVrcXJ6/xK1fj4apU1JV4XIOnfH2/s
	PRAD4cWuTp3Vun/6Wv8mjwDc2Axe/c9CVoG8RzSHETnbtOmw1PNvh1XQwJENwGCQArWc5gdpdtw
	hrjwU0vlk7prMFSoJUvqdam2ilh10LQuBF/RbIlRxr0nic+BloajVqdvA+yNTEEVD6SZeFw94Dc
	G/TorAX7/xLaS/cVmEu8NZooO6Su7zLzFPRzKxNCeybYmZ7mWsGx+X5LWv4Aelh1oVAYkVQUsTA
	pu5VKJNanX5lLl2u/bqHrN19laMjLSwVC8GKVTS38hK9dITvf4hhyo=
X-Received: by 2002:a05:620a:2a14:b0:939:16f6:4d01 with SMTP id af79cd13be357-93980371409mr3949925085a.21.1788997306930;
        Wed, 09 Sep 2026 16:41:46 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939b0aa9a29sm795461085a.7.2026.09.09.16.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 16:41:45 -0700 (PDT)
Date: Wed, 9 Sep 2026 19:41:43 -0400
From: Gregory Price <gourry@gourry.net>
To: Ackerley Tng <ackerleytng@google.com>
Cc: linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	pbonzini@redhat.com, seanjc@google.com, akpm@linux-foundation.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, shuah@kernel.org
Subject: Re: [PATCH 0/5] KVM: guest_memfd: bind backing memory to a NUMA node
Message-ID: <aqHtS6yKokjnhz2c@gourry-fedora-PF4VCD3F>
References: <20260902194657.79075-1-gourry@gourry.net>
 <CAEvNRgHWyBaBpZ4Bem1Eu86b-cuEA7NkyjxTJ4D3FnpGe1B2Yg@mail.gmail.com>
 <aqHkVKvons1tBs1O@gourry-fedora-PF4VCD3F>
 <CAEvNRgGAQj1afTRRO+DpVTaSCTZic3K_x6ZfwvBLUbfara5v=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEvNRgGAQj1afTRRO+DpVTaSCTZic3K_x6ZfwvBLUbfara5v=A@mail.gmail.com>

On Wed, Sep 09, 2026 at 04:23:07PM -0700, Ackerley Tng wrote:
> Gregory Price <gourry@gourry.net> writes:
> 
> > in fact at that granularity, the desired node may not even have eligible
> > memory to host the task's memory.
> >
> 
> We have a similar problem where we wanted only guest memory to be
> charged a certain memcg. Currently guest_memfd memory is charge to
> mm->owner, which is the thread's parent, so doing the fallocate() in a
> thread wasn't good enough. The workaround was to have the fallocate()
> done in a separate process (fork) and have the child process's memcg be
> set to the desired memcg.
> 
> This workaround is kind of awkward, but could it technically work for
> NUMA allocations?
> 

That is a very clunky work-around, I'm not sure it's good to formalize
that kind of design as an expected user behavior.

Whatever the case, the issue of ineligible memory isn't resolved by
this.  A node may be 100% ZONE_MOVABLE, and later entirely unmapped -
literally no eligible memory for kernel allocations for the task itself.

> >
> > This was a consideration - although it has other limitations and larger
> > complexities associated with it.
> >
> > Where does the policy live for random fd's? (inode? address_space?)
> >
> 
> Off the top of my head the policy would be saved at gi->policy, where
> it's stored for mbind() now. fd+offset is just another way of
> referencing the offsets to set the policy.
>

It makes sense for anon use cases like this, but for some random file
where fbind() means "put unmapped page cache on node X" the story is
less clear.

> > How is a reclaimed inode's policy handled? (lost forever?)
> >
> > figured i'd start by reducing the scope to the narrowest and clearest
> > use-case, but I did expect to have the fbind() conversation.
> >
> > I'm open to it, but it seems like over-engineering.
> >
> > If you look at tmpfs / shmem, you'll see there is the option for a
> > default filesystem-wide mempolicy that can be plumbed, but i'm not sure
> > there's a real usecase for per-file mempolicies that isn't literally
> > guest_memfd.
> >
> 
> I see, can't think of other use-cases for per-file mempolicies either.
> 

The only thing i've considered is something like GPU wanting a file
faulted directly onto its node - but that's a mapped region, and that's
handled by existing semantics.

> >> May I know more about the use case behind this new feature?
> >>
> >
> > see above - confidential vm whose memory is quarantined to a particular
> > device, without placing that same burden on the host memory.
> >
> 
> Is lazy allocation a requirement for you? (as opposed to fallocate()-ing
> before the guest touches pages)
> 

Yes, because eventually some kind of overcommit will be desired. May as
well build it in from the start.

Looking forward to LPC :]

~Gregory
