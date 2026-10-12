Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE293A5435
	for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799086; cv=none; b=cfd1yXkJMlM+MqAahbZYb86/mLEtfT8B+AShJWT5KwSlmMXCSdKJcIxJ9jOfk6qZ50SHsRhVWNKjmrKD5Qq8OWP/ZfvsnvZXy8nye/ol5bkT8V4NbrvSvsiHqFVtVdrfY3bxwqnnOTni9TQN4zpWeENpEnFLE0CzDbtd2s6DUEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799086; c=relaxed/simple;
	bh=8okIb6HYVMsdy6+U5xUzJ+gBO/rOBVZ3zjrTun8vSUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qh4CE7hfQInZkHSdkg55PPQGMEmt6JwMpHlXxPI9R8XzyojV1RLyGB22E7P+r69xcBa5Cy4tEwXl/Q8Mz6p8wEPxdJXA5MQmlxcDVLCwVlk50HMxAVIF3U726eL22PbN7xaMNLGjoXOWeYvW65YlOTbOYcRW7Nioa6ncBrAlrcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV15JsIm; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV15JsIm"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1aa27963eso1076309a12.1
        for <kvm@vger.kernel.org>; Mon, 12 Oct 2026 02:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791799082; x=1792403882; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8okIb6HYVMsdy6+U5xUzJ+gBO/rOBVZ3zjrTun8vSUo=;
        b=YV15JsImJ8S/3j9tPRykcGUsV1pFU1z//AAPJ8W8DZds3oRedH/iGnEoetHiMKpd11
         257epQYEHNK0kwBj1UczJc0fBrrHJXxHo7/0i5U2eoaqcrAFqsAHFOYVtiqyOtmWa+BP
         us0HV1Af/KdOTZNiRRYrqMEI1lFkEmPfww4Coo+bsSG60FcVfWewAPVJecI2fsNFR6Fk
         bCRTGxjBPLF7NLZDzy+oD/04k2imQBlNRReXmZk4hvaB833rx3Mm/CArip1mWOXFrY0Z
         GwhKuYbiIo1uSY9HsDk3e0zTAy7S+GmzdLVTkkeeTljnArjYiD2tvIH24hXWlzV/bltM
         bNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791799082; x=1792403882;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8okIb6HYVMsdy6+U5xUzJ+gBO/rOBVZ3zjrTun8vSUo=;
        b=xvk/8SlVfIrJYfXRGqyBoGriKRv+X4ZQmUAELCcO1SOxR394Ijz1wbdXloOf0tA9Uy
         qBdv/Q5YERaOAXu0aSJd3YqEO9AcGM9oLbcDQjMReCkpyVXc8K+neIUp8kWQIC2nc1OJ
         shBp+5BM91F+jFlCE2jiCsmTfTLHSNbQnVmscfLP28xHwqnBe2skU+OHapeGjpjCWkUu
         FHjJjEWMfFY1L7tcdAxg8ffJCSABfz0mmowZzrY5FWDGE93YYHp9Km7COa1YGHxAbCPx
         I1i0ruzPdgzRjT84LpIF/JtWyCZ/gC6R+biV+usgRHyyerhKGd08giGMCsqdaYovlW+S
         +Kcw==
X-Forwarded-Encrypted: i=1; AKwUvBw+qb/d2tM2gwa6mMjn46dirNjOmau4GbdE+08pKy9COOVsC6vFxMmkY/CFgQXQFJMK/IQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLwHahIDeA+QfFBcjZ1m7xX6cB3gcxU4e6TwEa+LmQBpLWjkTAx
	/AyiPspGILOkrtfL81PVGOUFXDOYtGdxnsNG4X+KUu2Kuslw7OQFtEPN
X-Gm-Gg: AYBFou3dzo4oHPg9thFnHTkceXqNIxq0wKgi5Kb8K0T4ZiwkjWTuT67J6jPGvRzaopA
	4vc07a+A9kMjUh68S3HWjMHgkNU9hWpv9g+YDvGo9+WfU8rzhzf/gMynwUAbk6jNunlY4x0sb9o
	WjMA9UQyRPixfzX03GJsDxzhSNE+Bj3iX4XbbM46P70sEGryC8XetJ72IxozPKOl0XM2wMbK1um
	G7L6ROnChNfMOitX3UBGhjIvwYCgZ45SorZ512jqXnqOAAHuKcZEs4kt/mph2+wMFXQovQlxBTS
	Zxvq69vKVDGWwOefbypIjMH3VcGITgxSCKCm5UweE2qKR57pzZUmiAUz88ULD4ZeT+4Vk1zo/km
	CMBQbYODeRlvoNIAmTX501Ma52H50RhYr4i7HzuzidQBuTo5g2uPsaQYnHVKAK7mHTi+UFTzcXR
	fvAexpb96LD5bUZXBbQnnR1m7HP5+lLvyuIbx4gWNFPzllhivl7Ezdvgo8JgN+cSeNrOYjSC431
	VuvVYa+wC4E28a15PtkxnR1jTNF4JlYD0MKjWFJu3XgZXSg9KQu5/weZuXJlGTdGYcQjzzfbapV
	cPYuKNLqkFAq6/ZPhiSpbp7EO2F3iAehBjk84NUEfzDodg==
X-Received: by 2002:a17:906:f59d:b0:c2a:b008:8cc0 with SMTP id a640c23a62f3a-c31a70e5566mr981263366b.28.1791799082342;
        Mon, 12 Oct 2026 02:58:02 -0700 (PDT)
Received: from dev-dsk-fgriffo-1c-93421965.eu-west-1.amazon.com (54-240-197-234.amazon.com. [54.240.197.234])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b178d1605fsm4928885a12.2.2026.10.12.02.58.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2026 02:58:01 -0700 (PDT)
From: Fred Griffoul <griffoul@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Ackerley Tng <ackerleytng@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	kvmarm@lists.linux.dev,
	iommu@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 0/9] mm: Memory providers for guest_memfd and iommufd
Date: Mon, 12 Oct 2026 09:58:00 +0000
Message-ID: <20261012095800.50250-1-griffoul@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <yq5ald8680t2.fsf@kernel.org>
References: <20260720111259.122911-1-dwmw2@infradead.org> <20261006183235.16576-1-griffoul@gmail.com> <yq5ald8680t2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Oct 10, 2026, Aneesh Kumar K.V wrote:
> I have been working on something similar for confidential computing use
> cases. There is likely some overlap between this series and what I posted
> at [1].
>
> I have not reviewed this series in detail yet, but I will compare the two
> approaches and identify what can be shared between the use cases. Please
> let me know how you would like to proceed.
>
> [1] https://lore.kernel.org/all/20261010072504.536230-1-aneesh.kumar@kernel.org/

Thanks for the pointer. I read your series, and Ackerley's resource fd
RFC that it builds on. The use cases differ, but the interfaces overlap,
and it would be good to agree on the common parts.

All three series add a flag and an fd to KVM_CREATE_GUEST_MEMFD. I
think one resource_fd is enough, with guest_memfd picking the backend
from the kind of file it gets. I am happy to drop provider_fd for
Ackerley's flag and field. We also find the provider from the file in
three different ways; I would like us to pick one, preferably without
a registry.

The main constraint on our side is that the provider stays the authority
on which frame backs which page: it moves pages between VMs and has to
survive a live update. What would not work for us is guest_memfd
becoming the primary manager of PFN memory, as Ackerley suggests. Your
get_pfn() leaves VFIO as the authority for the BAR, so I think we agree
there.

You refuse dma-buf exports while guest_memfd is attached. That is
roughly what the memory provider interface is for: one owner, several
users, and one revoke that reaches all of them. A BAR exposed as a
provider file could be mapped by both guest_memfd and iommufd.

I plan to change the revoke anyway, because iommufd must not leave the
device with a hole: it should replace mappings in place instead of
unmapping and remapping. Would that fit your case? I suspect it depends
on locking, for example whether you have to revoke while holding
memory_lock.

Shared/private state and the conversion hooks would stay in
guest_memfd and the arch code, as in your series.

Does that sound reasonable? Ackerley, David, any thoughts?

Thanks,
Fred
