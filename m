Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D2D4A2E23
	for <kvm@vger.kernel.org>; Tue,  9 Jun 2026 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022707; cv=none; b=pLMJ38AFwTnQ6z/V8O4Vs4MyYROijz9NS2zpbVqftnMZRVxe8htPfHrxm4A3YROPPfeOi0QWmM1J5/0Xylpa4JxenzwxsGGveFDT3FO79zm+jcB8NvuCyQNwSl8uPF5EipcmDI8KHTPdHOaNKC2X7EsCJdtGYWCqgr9GX7PQV8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022707; c=relaxed/simple;
	bh=/3EAZdmqy+2X2Fp3Q8W+pzNCGzEZMflvf/FBSzpx7WU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nHnZABarR233p7kuSWoR7xBmCuvXD6mxM9S/8FKMIYbczMmGM9vjOfMBS9nuF6ZL3Dda04Afuc5wIT13TKCTw5VBdQXXP8IEGTSKKubWp9kHBapdMGRmSAAi8iv+hyeRaK/aRjOXPg5PKZfMmtul0qPFupsOOdqM+D4oEo9osfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S/ggzkDS; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S/ggzkDS"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf243973c2so40005845ad.1
        for <kvm@vger.kernel.org>; Tue, 09 Jun 2026 09:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781022706; x=1781627506; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EI8CPPHCJ7Zmu9lqXV0PA5evSY9oUhH+2SIUAKzpTKg=;
        b=S/ggzkDSvRzhA24aDFCsM57gKUqK2aa6dwKoivz8+1qQ/Z0VJaNUYkM4k/p4NXz3XD
         yuVONhRWcUPqWv4/NFYcjCCBkPA2BBAxeDs9T4XClJ8g43+lRwXOwzj+f2/sxxf+Hi/y
         n5CMN333M9YfOQmrJe2unQ0in2NtB140jt/MbvrVO4UrNT0p07+5Lctxy2jvqUhkIfaj
         HqTmsd4CyUv95s2CprlDRtldQV8UlpSJnc3EjFQ8HaygGiBYFzmyptaEizeRYlj89yj+
         YumEu1xBxRfK8K4fuGJn1vn4NWKCnyHuhF27RYsqITtpjP77hYSMLqxOS6nyEsM1IwhS
         Bcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022706; x=1781627506;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EI8CPPHCJ7Zmu9lqXV0PA5evSY9oUhH+2SIUAKzpTKg=;
        b=DrSIsr54G47ORT9Ky3VfVfP8vFxJGKhpTqE19HdUBqgOAL2VdxZ2hrS2kZcNwxTK7b
         q03niB8SRWUVGLCAiqJY2mPhELnKB+59z+HGzSPy3QZC/lvdI2ey7qe+cUmPdZw+mpOa
         YzSJc/Vh4ojjm17PtYhHZtXWrpYuJUBFWOpPlWD9WBgOBZoqlk7ihZZD7yFP1UfMaSbr
         9uOyBCLdVtRL1VIjAZuTlthYc18bWzsjdIZBPqWyN+TSSOSAybLVa75kJ/0eRWF9p7lf
         /y+LGNJy9k+ipZ9c8cRfgQqzYKrA8qy+ze0KiiRmQOqC4aVip++wQ/bH5wAh1TQARpJD
         iLuw==
X-Forwarded-Encrypted: i=1; AFNElJ8yVisSNOCZokOXlHu5QoqZ1lzxwkWwcVqJNUPy+2wMQM7BnPRDYEk6m3z7XcH4mTG/kOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIAsD8danbweXHKusKBvc7rnV5mzHbGtYTo1hWb2u5Qbf/scDN
	oLUoPm8dY4nOI2mQzYzjkoIXz0Kq1W+qte3fC6Y4QRb6uhzUc6rt9XdmgCsf2LD2NAH/7FQlEtt
	pem5i/Q==
X-Received: from plge6.prod.google.com ([2002:a17:902:cf46:b0:2c0:e5f0:9416])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:c951:b0:2c0:a373:89b9
 with SMTP id d9443c01a7336-2c1e79e22d1mr249344275ad.6.1781022705646; Tue, 09
 Jun 2026 09:31:45 -0700 (PDT)
Date: Tue,  9 Jun 2026 09:31:29 -0700
In-Reply-To: <0eff0a90667b900bee837d06b5db5025e1f304b5.1780501924.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <0eff0a90667b900bee837d06b5db5025e1f304b5.1780501924.git.mst@redhat.com>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
Message-ID: <178102235481.2735841.1203781071933134475.b4-ty@google.com>
Subject: Re: [PATCH] KVM: guest_memfd: fix NUMA interleave index double-counting
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org, 
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Shivank Garg <shivankg@amd.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, 03 Jun 2026 11:57:33 -0400, Michael S. Tsirkin wrote:
> kvm_gmem_get_policy() sets *ilx to the full page offset
> (vm_pgoff + vma offset).  But get_vma_policy() adds the page
> offset on top of *ilx, so the offset is counted twice.  This
> causes NUMA interleaving to skip nodes: for order-0 pages the
> effective index jumps by 2 for each consecutive page.
> 
> The get_policy vm_op should return only a per-file bias in *ilx
> (like shmem_get_policy does with inode->i_ino), letting
> get_vma_policy() add the page-offset component.
> 
> [...]

Applied to kvm-x86 gmem, with a heavily massaged changelog to explicitly spell
out that ilx == interleave index, and to try and explain the role of the index
(it wasn't at all obvious to me why using the inode number was "correct").

Thanks!

[1/1] KVM: guest_memfd: fix NUMA interleave index double-counting
      https://github.com/kvm-x86/linux/commit/48dbe4732198

--
https://github.com/kvm-x86/linux/tree/next
