Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEAA542EF7
	for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791921246; cv=pass; b=tvcuK62+/wvAZvf7m+txdoBOVpIAAprC5IMXmSyO+LoerjF+FdJUCOBc4JosiSXGa/uBcxkZRuH3wdugtcBFP/f5ZckACb8GCiF2ae7mG3tKGzZeYaxMGKUM4lFFnD3/KE3x/u1o0Ck0QcF8Y0iiTGK1fziQA2vIn1GTz3IzK/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791921246; c=relaxed/simple;
	bh=gz/rGOEvzA8Irn4bo3jjQQgOvzTDOAdHYh6h6XK0A+I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfhIxTx21CuxIODpY675cnQKIbQ2HRkvMtG4fBIGPBFUVn7LbHPRNGvUXDcdIm36qGJLCOS+dtZ41GP8By8R1NzD9XIi1mNyuA8l7rmvO12sLyX8y5irtj8dsfsB9N5VyR6rAmZTY1DrtzAZXpAd8JO6op4s+3YLteLWo71MvXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AYWARZZI; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AYWARZZI"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-9178aabd30dso34044496d6.1
        for <kvm@vger.kernel.org>; Tue, 13 Oct 2026 12:54:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791921242; cv=none;
        d=google.com; s=arc-20260327;
        b=gCfcoq0b31mLWXP2bLeza+/Ybjp5frVJWBGAUr/+31407wUkmhP1SKeErrIK+p/nV6
         s8towz1ClD2rWx3uzdNwco6zl6AaE1oEuCIXpcA5nI2qOXTweBiaq+1hb4Eqny3GNUQ8
         JOKdIh//2qHClbeGhpxoRSlTaDhhRvnnwYGLUXdgxBbIjBaoH59NyhYIAtz6t1M4d1yE
         EF0j0Ahfxej+H+IrzRzuuWY98uTFTWXPdAkcfdGbAWurl0k4zW3eIi8EdlrX3kKTA2cW
         gubwl++ajFv+NSneQCaSVEy9q+bpxSpCNN/PBNhsjQPSOT1NUFIaTFpsvDlSBtJPioEw
         qekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=fjiIk8S/1b/fq42ObdZjHlUOMsEJstLh+gvZY/xKhZA=;
        fh=Ce9/ZcSHZhBjQccckCyH2m1g1HCq6bjAHS+LeC/Zn5E=;
        b=SB0fHnoKdVJVT4X8/DeP0tepEB48n8ps9+cCssQL3xMKyX43GtWUM5XgleHNyXoOrj
         yFduljlZKmdXnfXbkpClXrv0L79fnxs4jX++BAaMc9UZ1qThrYzH1Yg/Sa8xtV0LUaXc
         75z08IoLljSHMjYc1QNK8xqq01O5w5ReK+EVhLPbSbuiuOhkhSGpBqiNqGceDxJv+45l
         4dYBK4f3+WOddf2eoLAXK3MqYf1k6OvcA2akmVqALXTgtX27vBU/uyyQNkUxfi0rZdVe
         F1YT3CdhLUyrFfcgsNuBFxvkrrc2dtj0E7XxKRpAzwCSWB4Hw0fSnBwXjDr6KytWNhkh
         evCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791921242; x=1792526042; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fjiIk8S/1b/fq42ObdZjHlUOMsEJstLh+gvZY/xKhZA=;
        b=AYWARZZIgVGEohdhzynNKmu3krV6S3f1uZ2eEs7nq7bDRIxjtxJq+WlcllWjFMqt51
         /aE80MQB3UbTMp7oNRe5Y1ZD7i5Bdbpl0Zdu67h7dGtzb3upE42JBA/aFHl/xKzOj2YX
         xswOmCKZgdpQb5h8cPjITaGqIg5ZKEUMMH9G7rr60y9r0ucTyXWUuczb4oSSH8/Mg2z7
         rDvGjLN/xZV1W3y25BFCpCxWvxjNBD1KuiUlb0vrEu3+HWhdPq26IBCnzXM3FuR5lFtV
         huj8hful/ci1hwdxqqP+8eKptr8vUjPThf2gLYgXYelbzsmaAB19G9276TIaqU8pOwXX
         ygcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791921242; x=1792526042;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fjiIk8S/1b/fq42ObdZjHlUOMsEJstLh+gvZY/xKhZA=;
        b=DnId/RW4tpAe4BCnKNc1pSgzZm9mUHpYqTopFwi8wGbCT81s4NcHo3DC6+dndKnfJJ
         FDLCZfjXcotoGyYjN6WIo/UPeIWlYl8At8ivikaF4zDDlixnoBTIh7Y5TI38ClpYdnmd
         q/4U2kiOg5aM8hBeDfsjxOj9cX6oZWZPq7fWhsOv3Ri/p5Cp83JC3+Xmj6lUm4ZXhKTh
         KRmGkH6f/Mepwl7xnfBSromJ9SBzSkNUwingLwSbs/o7/6stllsbEcbVKUThaa93GYNX
         exB9PqYcx10bzIdi+JaIVnaAqvC0QGO37xT1yJLs41wXzeyWLINIbyWJ+YtOljl3W7S0
         hz6g==
X-Forwarded-Encrypted: i=1; AKwUvByhtUz812HRLB9tx5lmkbCwH9eL6hfRnF/WAx+tIWoD9bM7KiZcZcxI67DcNQD5dOb9Ftw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjLZxUw/s0ObXZA5lPfJtuuHFVt/f/R7bQO+Zxz+PQCREl62M9
	8pMaLXouVsrfoU+1kKx4pEP+Dgq6qescIxFgX7pJoQXXFSrRn0FHUvl5cuchDqLhrbMNNh+BFwz
	9MQg3Ali/3b/abymqrhMxbNrUtJo9UoMVIyAVD3MJ
X-Gm-Gg: AYBFou3wiwjL216SeGCRnhTd1Elb6FQDkV0ANNgAbGEL9NN63080QLX5u8fYMj7ivYo
	XmPv+z6f1vIvhfoCe4nf9yNJOVufYXvhOicDF8AhJMFuYkhNPYRamR+2qMQfLfBos6thfBF7Mw6
	4OYfeY2mi18y1JkYmjyG8hR51xarDcVShc5Jj93mst6ZshmO1wuSUTVA4VDiHDJPA5dX2M/D1aC
	STRlKalatkYe1fkwAcYhXOncy5mcz12ftdiHnyBomt2EnD5kqJ73ym+hSwU4KWY8smsPZCe5Xtt
	5WUdsXHAKIqvpV6kJyPvwQBbOr8jpXvCFx0okAOKkdItu9UkHkDcxQazmmJ1z/HSn5yGi7BQBC1
	tyWXXt48ZIXwOhYhPV3Rlbinls4sAyP6m6KOl2ZwNTQ==
X-Received: by 2002:a05:6214:5085:b0:90c:b843:d679 with SMTP id
 6a1803df08f44-91b555668b1mr241693526d6.29.1791921240685; Tue, 13 Oct 2026
 12:54:00 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Oct 2026 12:53:59 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Oct 2026 12:53:59 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261006183235.16576-1-griffoul@gmail.com>
References: <20260720111259.122911-1-dwmw2@infradead.org> <20261006183235.16576-1-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 13 Oct 2026 12:53:59 -0700
X-Gm-Features: AclHuK8TQPboa9RVDrBS_-w6dTXGHf21nXTRvYl_CuU35T-tn195uLjZFRceV3k
Message-ID: <CAEvNRgEseLO+LbkwXrEit0H2LH5Wx-srSvHEMpt0=upPL3tF=g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] mm: Memory providers for guest_memfd and iommufd
To: Fred Griffoul <griffoul@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, aik@amd.com, 
	jacob.pan@linux.microsoft.com, gourry@gourry.net, vannapurve@google.com, 
	fvdl@google.com, tabba@google.com, dave.jiang@intel.com, 
	aneesh.kumar@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey David/Fred,

I took some time to read the patches, hope I got everything :) The
biggest difference between your approach and mine is who (provider or
guest_memfd) manages the zapping across all the users.

The memory users here are

1. [KVM] The guest (KVM manages the stage 2 page tables)
2. [IOMMU] The IOMMU (iommufd manages the stage 2 page tables)
3. [USERSPACE] Host userspace (guest_memfd handles faults, I guess you
   could say core mm manages host userspace page tables)
4. [DIRECTMAP] Kernel direct map. Your provider already provides PFNs
   that are presumably not in the direct map. For other providers, the
   direct map is another mapping that may need to be zapped on
   private/shared conversions. (Listing this here for completeness, I
   think this should be tackled separately.)

I'll use [LABEL] to illustrate the way notifications flow in your
approach vs mine.

When the provider wants to revoke the page, the notifications/function
calls flow this way, the last [ENTITY] in the chain actually does the
zapping.

+ [PROVIDER] -> [KVM]
+ [PROVIDER] -> [DMABUF] -> [IOMMU]
+ [PROVIDER] -> [GUEST_MEMFD] -> [USERSPACE] (AFAICT this was not
  implemented in the RFC.)

That's when the provider wants to revoke the page. IIUC guest_memfd
conversions was not illustrated in the RFC: what happens on a shared
-> private conversion?

+ [KVM]: Zap only shared pages, keep private pages mapped.
+ [IOMMU]:
    + Before Confidential IO: so far, IOMMU mappings are mapped
      indirectly via [USERSPACE] mappings. guest_memfd zaps
      [USERSPACE] mappings, then checks refcounts to ensure no other
      mappings (which includes IOMMU). See __kvm_gmem_set_attributes()
      on kvm-x86/coco [2].
    + With Confidential IO: shared IOMMU mapping need to be zapped,
      keep mappings of private pages.
+ [USERSPACE]: Zap all mappings on shared->private conversions.
+ [DIRECTMAP]: Can zap these mappings (not implemented yet, but
  discussed in the context of Direct Map Removal support for
  guest_memfd [3])

To have the conversions work, in your model, we'd need to do

+ [GUEST_MEMFD] -> [PROVIDER] -> [KVM] (zap only shared pages)
+ [GUEST_MEMFD] -> [PROVIDER] -> [DMABUF] -> [IOMMU] (zap only shared pages)
+ [GUEST_MEMFD] -> [USERSPACE] (IIUC the provider doesn't directly
  allow mapping to userspace, also in your approach the provider
  pretty much replaces all the innards of guest_memfd anyway, hence
  I'm showing this as gmem going direct to zap userspace)

With my proposal [1], we could do

+ [GUEST_MEMFD] -> [KVM] (zap only shared pages, implemented in [2])
+ [GUEST_MEMFD] -> [IOMMU] (zap only shared pages)
+ [GUEST_MEMFD] -> [USERSPACE] (implemented in [2])
+ [GUEST_MEMFD] -> [DIRECTMAP] (future)

In my proposal, I agree with you completely that the provider must be
allowed to revoke memory. Using the sample in this RFC, gmem_fd_ioctl()
called with !GMEM_PROVIDER_SET_PRESENT is where the provider wants to
revoke memory, and the revocation in my model would look like

  [PROVIDER] -> [GUEST_MEMFD]

and [GUEST_MEMFD] would then fan it out to [KVM], [IOMMU], [USERSPACE]
and [DIRECTMAP].

The [GUEST_MEMFD] -> [IOMMU] is missing from my proposal because I was
seeing that as a separate patch series. I think what we want is to have
IOMMU_IOAS_MAP_FILE be able to accept a guest_memfd file. Currently,
during the mapping process(), memfd_pin_folios() is used, which has this
check

	if (!shmem_file(memfd) && !is_file_hugepages(memfd))
		return -EINVAL;

that disqualifies guest_memfd. Refcounting won't work for guest_memfd()
folios because of conversions (see kvm_gmem_has_outstanding_references
at [4]). The implementation I have in mind is to have the the iommufd
instance be tracked in guest_memfd during the pinning process, and
that's the pointer guest_memfd will use to get iommufd to zap during
[GUEST_MEMFD] -> [IOMMU]. This [GUEST_MEMFD] -> [IOMMU] zapping was
previously also proposed in the context of Confidential IO [5].

[1] https://lore.kernel.org/all/20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com/
[2] https://github.com/kvm-x86/linux/blob/a6270ed4bec0caa25913082e71ce22254e9cd3ed/virt/kvm/guest_memfd.c#L685
[3] https://lore.kernel.org/all/20260410151746.61150-1-kalyazin@amazon.com/
[4] https://github.com/kvm-x86/linux/blob/a6270ed4bec0caa25913082e71ce22254e9cd3ed/virt/kvm/guest_memfd.c#L722
[5] https://lore.kernel.org/all/20260225075211.3353194-1-aik@amd.com/

I'm intentionally avoiding the "primary manager" terminology since
that's overly broad and doesn't really explain what processes exactly
are being managed. It's really just which entity tells which other
entity to zap pages, and since shared/private-ness of memory is core to
guest_memfd, I think guest_memfd is in the best position to tell all the
other entities to zap, and what (shared/private to zap).

Does your provider need to know if some memory was transitioned between
shared/private states? The provider can be notified too, if
necessary. If not, then isn't guest_memfd doing all the coordination
better than going via the provider?

Does the revocation model work for you? If it helps, I can rebuild the
sample provider to illustrate how the revocation can be done. Let me
know what else is missing from my model [1]. :)
