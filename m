Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8421C2F8EB0
	for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 23:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781567198; cv=pass; b=M1wuFCZMKTtmUsBWoJW8GA+8M0TFEuEo+5/jAlS4YE7nDMyRcb/u+GAkmZDJLz5j19LK7bGlQsWTKbEtZpOLnT45Bwm+7DNBJe0x1Oco/bNVD4dvhumb7Ehwy0NZIFuQExAH41RvaAC3RZ8zd25WNLYYQyhQS/peeyFo6G/OsrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781567198; c=relaxed/simple;
	bh=I+nWA545jB467TF+kyDxBRzn7JtAPzZzw87eodkUA64=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNRPblhoBMlP5QF9QLgEQP0gkSYOfRscuhEKYUei4AVs5fXweOzpHhxfVDNODSdyeXjGkVk1qEq3nKpC/YyZNta0tYH28QGvx9BVh2jbAQhO7Co09dlKongFake/YNHn9Q5UtZW2QkN3s70+5PFXwUuhmUxe1Aac2VtCCKBHxVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rly6qVG+; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rly6qVG+"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-137dd4cc208so2075578c88.1
        for <kvm@vger.kernel.org>; Mon, 15 Jun 2026 16:46:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781567197; cv=none;
        d=google.com; s=arc-20240605;
        b=KGNBziu8MKWYYMo/STsD24330JAUZvA5I1C542VG28eACRP9E7owGtAx015XDuqE0T
         6/4qyS0hPhPZkZyUh1sRRyL3ZfCGKTUBz8+wh0EJpDJs/uKnt6y+VwdYo15BuEMHIBzh
         PxNAcf6mdx2+UlSgdaypzQKPwbXoQaVHMc+jro4xk8EZynxQWwQd6+KEC+/C8qQWkeSp
         ZcFnXgQFQHFZpyMbXgK7cgdcjY6lLd5zm6t4JR9utZUBKG07DdNEIIm4y2XHzINtuz3W
         0/whokKv1Pnv0qMk9E9l2+d1VwgAmqNhxpaIs0DaYBTtTYVFNIwOIU04KAsQqxvc0b5Y
         nIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=ObEUf0E9nYIpFpN+Yp639n4XU8L7FHa7f/UlfLhBApI=;
        fh=U/CpoaEEaBNJ+8R1EOwGjl9LqWi8QcI/jZpk+X4HgdQ=;
        b=Ob3YEzOqW6T3F74iDrgEszlggNVLWcp2VTaKp7qFmQss/9gFzfyN+HSfH6S39CKFx0
         hKZlVqH3iTtcYPNu4WwIgRBL0+hmI2wW6HkMUjJrgaMa92FXR8kv2dQFT8ssFW0qZE8V
         l2VbFYMXzozgJxrnuQ4Ous2b2iLswYCt54Ab2VJw9jgr4102DmN/GytkInW3eWYKzkIR
         O4D9NLIJf0ISo8VWUb1ovEJGg7i96VhfYhs62Vmq/OUDbjziob5PqZeW8l8qCWQ/IYL8
         8DH3d1dwCeGl5xioWgPelYTrunidmR490O5R0ehzNVQzWx/ZCyKzJF+SnAgdBwIGGzLE
         n44A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781567197; x=1782171997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ObEUf0E9nYIpFpN+Yp639n4XU8L7FHa7f/UlfLhBApI=;
        b=rly6qVG+rEc97y7p1jhaWZFn3d8zaElfwB+oOC2zY40JMwUH7U1ePj0nHbZNRJ3WKC
         mog1SDUxpLbPFTw4PQbwesnVQtKSQXlMAAycbY77cThnqtTGQMGyALt7rgQCnwjjNAXC
         m4BVuJDeatlGDTByUCvlfi4aS7dCh0n7+iBrk9nP3BxfYcEpeei19l+ZuZ3LLgEpL7ek
         wgm2x1dVEgtgrXa+gMw4KQXTMvo1F9Aw9Iq4uVT7xovP/hccDSsfTJBiugI8KD58p9ee
         RkbyishiJ5jazgJcwjDVJjfwlMsSKxpFuokxveEeNpJXMfTHe+YT+ZMOXIZ8LcPx0Hbm
         N0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781567197; x=1782171997;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObEUf0E9nYIpFpN+Yp639n4XU8L7FHa7f/UlfLhBApI=;
        b=UtKJyT5BIyJRIhuGN0HyfidOW8icBRnvapc7HpxfAqc9ZY3eVF5RPIK7BqHXJ83fOi
         Kj0IhaP/fZ9QJt1rcedCVhWw39jSHFaJ2o8sjsn22YizrDqc/NICiXu/AiiSTkdDpe16
         Oi6kStBQhDL6/oMUz2bsf9aN/yQlCLEuyF1C2shoSSY/35VM5UqOJk6BADnJdQHfrYzX
         5vVMbol2krMrBBfSHn1ooiPwFNTzeU1u+V1bhdUl2D8/XWeJSV3w0sHG/voLDTHBOFHj
         VEy5mJeU1NHu/ZKlgmfMXaj1+/3O5IDgoaYVaU1I9HSJw02J9X6ZHxhPzPQ/RurgJ06s
         KRsA==
X-Forwarded-Encrypted: i=1; AFNElJ/gZcNGSlAlc7t/ZpwxkfdOgtzV8FKSL7eAcBGJXIgHuR4hJmzSSXpslaHoclx0hwNw3QM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgpwjyi77S3saAF4Sqp65ynUdSPtDKF7FjF5Flyzye8AkPoWsA
	BnzCaKg1uGbMMwr47HlAg88agECCdBChibfJEfkNa6u03LtHIja+bAkAxYV9ioimQfRTgW4DVoO
	GCwBc05jNjM5SoglnhdM/fX0ZNhH/UdZXcQrHKsOt
X-Gm-Gg: Acq92OG5N5PsKYNDW5H68SU2j3MXhth2KhvGLu4e/nr8CeDOvDP2D9FVJlyebIX86Di
	qFVmr7gbmBqLf9sspplVi3FwIoS12cBAk1jv1zfqx3aHItrbmhZhhMx4qvMZXp3sAnSP1hYXyPc
	fJGpFZV0ogsnF1/ItctwsW7nRgri+tWD7dxNlizYVF+V0BFN7lakUgOT9jSINB0mj3pNsSHSrau
	E4smL5+T1Q8TsqyMXfyLfYVp3tdID5z68CZ2Pzb/w3s00fvNzmeIb1CJ52hj/vjeAHdIfEaGehc
	1kYR08PUbfvZf1YilDkohpBWJEI/KRHU5bQZ51+RPdZrYYHwFFnqmoMd46MIL/BvVT8s
X-Received: by 2002:a05:7022:689a:b0:138:40b4:6cf9 with SMTP id
 a92af1059eb24-139858102f4mr725236c88.19.1781567195936; Mon, 15 Jun 2026
 16:46:35 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jun 2026 16:46:35 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jun 2026 16:46:35 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260521-tdx-selftests-v13-v13-13-6983ae4c3a4d@google.com>
References: <20260521-tdx-selftests-v13-v13-0-6983ae4c3a4d@google.com> <20260521-tdx-selftests-v13-v13-13-6983ae4c3a4d@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 15 Jun 2026 16:46:35 -0700
X-Gm-Features: AVVi8CfMUcsxFfG3l14C_ZxMq1_qiC853xZ-90KAH7coZFexwbjDcBX_tp12FV4
Message-ID: <CAEvNRgEBiivp9tOHZnFmWvF6ek-Ar-m2B+hb=-H0dgAcM2=z8Q@mail.gmail.com>
Subject: Re: [PATCH v13 13/22] KVM: selftests: Set first memory region as
 shared if guest_memfd
To: Lisa Wang <wyihan@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Ira Weiny <ira.weiny@intel.com>, 
	Isaku Yamahata <isaku.yamahata@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Roger Wang <runanwang@google.com>, 
	Ryan Afranji <afranji@google.com>, Sagi Shahar <sagis@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Jeremiah McReynolds <jmcrey@google.com>, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Lisa Wang <wyihan@google.com> writes:

> Set the initial state of the first memory region as shared if it is
> backed by guest_memfd, so that the KVM selftest framework functions can
> populate mmap()-ed guest_memfd memory the same way memory from other
> memory providers are populated.
>
> For CoCo VMs, pages that need to be private are explicitly set to
> private before executing the VM.
>
>
> [...snip...]
>
> @@ -495,14 +497,16 @@ struct kvm_vm *__vm_create(struct vm_shape shape, u32 nr_runnable_vcpus,
>  	vm = ____vm_create(shape);
>
>  	/*
> -	 * Force GUEST_MEMFD for the primary memory region if necessary, e.g.
> -	 * for CoCo VMs that require GUEST_MEMFD backed private memory.
> +	 * Force GUEST_MEMFD for the primary memory region if necessary, and
> +	 * initialize it as shared so the selftest framework can populate it
> +	 * exactly like other memory providers.
>  	 */
> -	flags = 0;
> -	if (is_guest_memfd_required(shape))
> +	if (is_guest_memfd_required(shape)) {
>  		flags |= KVM_MEM_GUEST_MEMFD;
> +		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
> +	}
>

Just noticed this while hacking some SNP tests.

> -	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags);
> +	vm_mem_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags, -1, 0, gmem_flags);
>  	for (i = 0; i < NR_MEM_REGIONS; i++)
>  		vm->memslots[i] = 0;
>
>
> --
> 2.54.0.746.g67dd491aae-goog

I think this patch should fully buy into in-place conversions, so we
need to also set GUEST_MEMFD_FLAG_MMAP:

@@ -483,6 +483,7 @@ struct kvm_vm *__vm_create(struct vm_shape shape,
u32 nr_runnable_vcpus,
 {
 	u64 nr_pages = vm_nr_pages_required(shape.mode, nr_runnable_vcpus,
 						 nr_extra_pages);
+	enum vm_mem_backing_src_type src_type = VM_MEM_SRC_ANONYMOUS;
 	struct userspace_mem_region *slot0;
 	u64 gmem_flags = 0;
 	struct kvm_vm *vm;
@@ -503,10 +504,16 @@ struct kvm_vm *__vm_create(struct vm_shape
shape, u32 nr_runnable_vcpus,
 	 */
 	if (is_guest_memfd_required(shape)) {
 		flags |= KVM_MEM_GUEST_MEMFD;
-		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED;
+		gmem_flags |= GUEST_MEMFD_FLAG_INIT_SHARED | GUEST_MEMFD_FLAG_MMAP;
+		/*
+		 * TODO: Clean this up together with vm_mem_add(). Use
+		 * VM_MEM_SRC_SHMEM to tell vm_mem_add() to mmap
+		 * guest_memfd with MAP_SHARED.
+		 */
+		src_type = VM_MEM_SRC_SHMEM;
 	}

-	vm_mem_add(vm, VM_MEM_SRC_ANONYMOUS, 0, 0, nr_pages, flags, -1, 0,
gmem_flags);
+	vm_mem_add(vm, src_type, 0, 0, nr_pages, flags, -1, 0, gmem_flags);
 	for (i = 0; i < NR_MEM_REGIONS; i++)
 		vm->memslots[i] = 0;

The VM_MEM_SRC_SHMEM is a bit of a hack but imo that refactor should go
with another series to clean up vm_mem_add().

The above code was working for TDX because vm_mem_add() without the
guest_memfd MMAP flag would leave region->fd as -1. Without
setting src_type to VM_MEM_SRC_ANONYMOUS, the assertion in vm_mem_add()

  region->fd == -1 || backing_src_is_shared(src_type)

would pass.

tdx_init_mem_region() was called with the anonymously mmap()-ed address,
which turns out fine.

With the above change, we would also need to call tdx_init_mem_region()
with NULL for source_address.
