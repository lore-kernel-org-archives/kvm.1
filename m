Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA45B4718D7
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 14:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814286; cv=pass; b=gkODw8LKfr5o5FqUkR5DB/L5FS+71YmylruJdosK3a3vipukL+jwhHY5c784nuHssry8TDqfLnogKOZgvZf639QL0KqafioefEG+NS+MK2dUSH1G2hgrVAHutvH94vlHMuG18Zz9UREgHPD/HnGF9k647JHAbtwnVDB897El7UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814286; c=relaxed/simple;
	bh=toTfP3XAamHR53tLn5nTeuCeveBATzueww87oO23fhc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYhmlT5nwmBhrmKXdmL/pA8UCusIET/nFrBDf1NxfEP0Ao9CTg5sbPHOe6bAsdcqc6jDCfiBbo4UJaOXmmf4NHezma3ZE1yzmpc1w144SF3GwsSTzCoZHeZVlUQDmSUlx9raj6c8JYiWKdjEfUXJfrZhaRymeE3/QY/B0lbenhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=riuHiHDN; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="riuHiHDN"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-91b54d1e9cdso21111866d6.1
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 07:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791814283; cv=none;
        d=google.com; s=arc-20260327;
        b=c6qCr8Nw39H2Ubrz1PTFXlWxCihbMRWggQCu+qti9p8U5ZY8RHyiJNKFFp/Z5HJluB
         sQ6LBXKIf9i1mipQrecLDUcOXKzV2nrOaamA3ojdYO5QYfHRV3cjqIzG/vSIRQMyW6iq
         QSbih9LzSKi517a0u5fnUVf6j+wmFBhwh3w1/aOiQCC6ZykXM6qKbzeppNunIGkIUHLo
         M50MP7sK/RCDxWm13M2bq+rPBCcufMhOWW8PC7JoZ5FSv5ary4zJ3vZu+9srZgZdYTZ8
         fP/usU0fh+pGG7o2xEOgZFPOX4ZlC1w/MnzmO0Lxm1Ewt+C3k+IWREKjLRgMmfG58G3j
         gtvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=K2I843zxPr9lME1nSEmz+NsS/OxECT+sAh7A1cwprg8=;
        fh=NE0w5fZFJqlfxt1gGTjEg0nikvKdLeCF0QEwplxCrhU=;
        b=h/YxBAD5Js9rEhbfJRQOhWUIhuyEr2WkrsdcvuKzmplFQLXzLSR+ZLgVmx2Xme5JO3
         H84+qBJKlZ2jkWXlszsBN8ex6TM8KGgycaDUEGwAlxiIDG/DqaYb7oVQM+eWvhuKahvf
         Uw45+zN9sAeefROwZgnqXNwb8MRPWxsKOfe+l6NCk0v4enczFJYlKAJUa+Ir52B7C+hp
         zI6FPfTCreiliYoay0Wge7kHi8Ls0Y4E7TpPvSv4YwYQgCzNSCGvl1gDeMqogyDQL3g3
         7teM/DccPSK51iBGnV4yibPAAhhdEKW0QF+S7/Fns9+RRZoBUpy0mR4gINFU9wmev8cE
         CxBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791814283; x=1792419083; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K2I843zxPr9lME1nSEmz+NsS/OxECT+sAh7A1cwprg8=;
        b=riuHiHDNI9VbFbKH0rde37/ykIQHmtHxc4wUw4QOAJXPzsnzi8j+1eiNfM0X4MguS4
         JXwovS5bZUNydRY/IxjZYYmuQpkw+RJvr9LfcZXyjpTz2u87kRr7GiKsTieVmsanIWkL
         UwjCPacdD2mICgm1V3og5rguoRO5WIdCWYbxD9AijiQXbBYr386NufiBinUAEpfXH4+X
         jLIJt4F2o9i9m6KcdyFwCTnsW3PD+DSRKDYlvQLjNV08LUFp5TymTaNl5EtsTWwAovql
         mmu94+cOesk/2rCSd0D/Tg3YDsQ4g2d2FlPJtslOfah444xvgzoWE/Atm/cGEmQbc26u
         Xw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791814283; x=1792419083;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K2I843zxPr9lME1nSEmz+NsS/OxECT+sAh7A1cwprg8=;
        b=REZyiFxfnPcpn4RTz4dDjBDdJiKZqJ7LcAEXXNgzMXwgaS+fEBarzjveBfNIe385vz
         cVdxFpiFGERjkwzGQup2iVmmpTR3vMMvrpbc6nOnGT/e5H/8rhSmndFQfdsE7IMaWU/g
         VXbNPb7jWOiV+vsfn/9yXow57C2BrupAo7nZEqShqvTOHYak6ZLU2rFTvRtiUneyqMg6
         iEGEekPpY0DHxtmXn3hOs1ercYXGaf2uML9USI4LEuMTQv4NO2d3tyDLqJsG0+6V91C8
         Do2fHEyBFJ9G/AVO/36oKMO/pdK79wjZQoxX3LVlxgRMsaN+/QcvUsag0o3U56EZfs7I
         JqHA==
X-Forwarded-Encrypted: i=1; AKwUvBwcbSd6nx02syCfQt1zSUu9o6e6KGx3N9m+V5cZ2d0sttGHa7I6X32F8gPeT9mMre+C0oc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLBzcy62geGffuSOcKjmeOarVHxNsmsu1eyfQLB3nzoOqKTt15t
	ViGaTIhIG0A5EQq3QwOqpry/5VFPWOPYynGid3Lo8fPBpbfQca/l6YxVKi64nMCE/pNZbdoPVZd
	MLUjnpYMP0GoAjsLYhzYuyq7Ldbt1ZKpwQJgwEquV
X-Gm-Gg: AYBFou0FymM+e3uiOJB2wWFqTyXnVRYHBLDDoLydGXjCa9e96OUwnkdmk+bTnxZN/EZ
	x89M12ITBd9/dpANGtiyWAmo4RuHK/E3aGTkiB4cQUZo6JIySMos4O6/ZGz7ej7M7zwqTHEOVAK
	orfj4RGfxusM85B6sM5+HX4rY3MUGkjyR/bmsbLkLrMrg49AdgqcJUh/uk4yLCOqqX47ikHLhME
	wq4sAVhWWz33yS8E1s/e+4KFtKOFlQzV+mqVv3wgNuJCevETqZn0D5YzXZCPjjCLbMG46oEWIaD
	aHRaJgABcwl25WuvE42ScYZjq23QhFq0wFyoiDe5pZXTWn3/58iaHYD74+kO98gDUJHTW1YfwYE
	ihwhWWsRK1ln7MVFf3w9K
X-Received: by 2002:a05:6214:23ca:b0:91b:8e83:e4b0 with SMTP id
 6a1803df08f44-91b8e83f3b3mr19792736d6.20.1791814281518; Mon, 12 Oct 2026
 07:11:21 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Oct 2026 07:11:20 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Oct 2026 07:11:20 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <ar5iaaLcyz9dCXQI@gourry-fedora-PF4VCD3F>
References: <20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com> <ar5iaaLcyz9dCXQI@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Oct 2026 07:11:20 -0700
X-Gm-Features: AclHuK-GAlH1JSAYNCIS06aJZxJfvunIjbH1E5FXsRqa5lYNWWJsyEqAXZVZwzo
Message-ID: <CAEvNRgFO5FUFwU2GEEbHogLmT+SXVu1asLe5uzvRte2jqXthUg@mail.gmail.com>
Subject: Re: [PATCH RFC 00/17] Allow guest_memfd to be created using a
 resource (pool) fd
To: Gregory Price <gourry@gourry.net>
Cc: Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, vannapurve@google.com, erdemaktas@google.com, 
	jxgao@google.com, rientjes@google.com, fvdl@google.com, jthoughton@google.com, 
	tarunsahu@google.com, pratyush@kernel.org, fuad.tabba@linux.dev, 
	David Woodhouse <dwmw2@infradead.org>, yan.y.zhao@intel.com, michael.roth@amd.com, 
	suzuki.poulose@arm.com, Christian Brauner <brauner@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Nicolin Chen <nicolinc@nvidia.com>, Xu Yilun <yilun.xu@linux.intel.com>, aik@amd.com, 
	aneesh.kumar@kernel.org, Vlastimil Babka <vbabka@kernel.org>, kernel-team@android.com, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Gregory Price <gourry@gourry.net> writes:

> On Fri, Sep 25, 2026 at 05:50:47PM -0700, Ackerley Tng wrote:
>> + e.g. for tmpfs,
>>     + Use mount page size.
>>     + Respect mount size limits.
>>     + Use guest_memfd mpol and fall back to mount mpol.
>>         + Gregory, now you can set mpol upfront on a mount! [3])
>
> I haven't had time to quite give this the read it deserves yet (have
> been traveling this past week), but I think this mpol/mount issue can
> be solved with a new dax driver (which maybe provides this provider
> interface) without needing to involve numa policy at all.
>
> Essentially
>
> fd = open("/dev/cxl_dev", ...); /* backed by anondax driver */
>
> then later when a fault on that fd happens, the driver provides an
> anon-memory allocation that explicitly requests the node associated
> with that device - as opposed to trying to jam this into mempolicy.
>
> If you're planning to be at LPC, happy to discuss this in person, but I
> think this provider pattern is likely much cleaner without mempolicy at
> all if you can just make the provider do that allocation path for you.
>

Nice meeting you at LPC :)

I agree with you, I don't mean to require some kind of mempolicy setup
for every provider.

IIUC you're saying the entire /dev/cxl_dev is some fixed NUMA node, any
allocations from /dev/cxl_dev is from that NUMA node?

In that case, if /dev/cxl_dev is used with guest_memfd, guest_memfd's
configured mpol, as in kvm_gmem_set_policy [1], just can't apply
then. /dev/cxl_dev fully controls where the memory is allocated.

On traditional mounts like HugeTLBfs or tmpfs mounts where the mount
config supports mpol definitions, we first apply guest_memfd's
configured mpol, and fallback to the mount's policy if there was no
configured mpol for guest_memfd.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/virt/kvm/guest_memfd.c#n400

> ~Gregory
