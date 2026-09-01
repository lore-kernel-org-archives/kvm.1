Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C8416870
	for <kvm@vger.kernel.org>; Tue,  1 Sep 2026 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275081; cv=none; b=nwphSpNZVUmyEysNVsB/+ja1CleWda7HyKyXthtpFPXgdOrfhbJXv8ftD++A/wQj5PSCLD7TbSuVnFGL7uUDphhhpwfVSlqsd6dEDmOGkiJ4LMG4cv/FfE+vyJ7hDf/njxPaZRedjE2VXdSv1Xl7pyZp+toNWzYHu0tAT3I8tCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275081; c=relaxed/simple;
	bh=tpdO18xICJ5y9qBS7LZamGFxvdeqjw46wDaY+iq0bPI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mZkk89khZXsL14rgGgJUduA/noxpTB2myNP1Bdmksc2AOavxSgQQpCNzGSzoSBmFdnY0gkyW9j9CJLFySRCJj3jhSz3lEPYMCgl98m7NECZFN+ZGkJp9q+gmsmhXpjHr9FUq6R0Q3kjTwgPh8qu1tsVBuyp3SWqAJ87CvmvT1xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VpMQ1djU; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VpMQ1djU"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc132709c76so7920760a12.3
        for <kvm@vger.kernel.org>; Tue, 01 Sep 2026 08:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788275078; x=1788879878; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UgCARssVX+b4Z43xPlj6rs96AWy4osjZB7qoxt3QrO0=;
        b=VpMQ1djUopgW/qK8KWR3SFkvRoC6qsf6RnCPqNsBvyJVofjL9RQO0hiRysDCTWI6GE
         6/JMjQwnUWY39cCeRwcMD0aeAXTnorjw1S2VIXoI4HmcZnAwuxEjILaFedL3ghOENtxD
         r9zyQ+ywZlvbN7UGfphsSq2ZxR42qLTgngpXjSzztI8LJwMChgRFLtqBr80MquCcwLRc
         Xo4mPrL4WjbJ3ILa0Suq/hAEH1kF2GNLtJpsuCQVpYOSOd5ag7wmZASnT0BEgjgJyTXY
         HtZkScNZMoRSn1Z3z4XzV2wKdv1ahsMrwIalS0BXuLjCkHR+l9wxGKsyREKOnLfDlX83
         TAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788275078; x=1788879878;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UgCARssVX+b4Z43xPlj6rs96AWy4osjZB7qoxt3QrO0=;
        b=oeiIaypL7i0FJVKcV+yOqbEsTnm174Asgx2ujo8XHks7YCzRgfF7gK3HvjIOSIGl+w
         qkzYb7lfu034LHnlfQOOzRbomUCXpR+PDEKB5MBoupNKX1UninNnl5s5vjYA6qfOfiGw
         1iLl98EGuhBL7Mv/nPSlT+sjuRK2vSgZOa9Qp0RvH16PFpFYlWmqy2TruouA0mfY+uQ9
         b+fydCulka24my/RFkUYw/OANgw8NW/WqBETTHwvjG3d8rInxDk6Tmv3jpOvuzwdrieo
         hPheXDB0DRrepO0qGwAcDaQxvE96SJoKBzv/9dT2Flo/0YpFTFnAmfzvPTHQVBL2nes4
         5HHA==
X-Forwarded-Encrypted: i=1; AHgh+RpVMf92uxWeGWNQRVyuUoxdqATzTifPhCNT7JjXe7LDEu+h+XMPEBEdo9cddMRhGCYiohI=@vger.kernel.org
X-Gm-Message-State: AFuF++k7WG/H9l339ttD7V0LrptZC4ayQvxt0cu0EOrFqelTm7v2O1Q+
	3qDJeckzJ270MWAI0gpc+/MTK3FvfOsbydc/p1Ptwpu+vB9Yz4cmuRUaiuFMj5I0vq7Pk4V7+P7
	L6L2UBQ==
X-Received: from pgcga9.prod.google.com ([2002:a05:6a02:6689:b0:c9e:28e0:16dd])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6017:b0:3b4:61f:1fec
 with SMTP id adf61e73a8af0-3d7adeb5aa1mr14590054637.2.1788275077870; Tue, 01
 Sep 2026 08:04:37 -0700 (PDT)
Date: Tue, 1 Sep 2026 08:04:37 -0700
In-Reply-To: <20260901-gmem-selftests-fix-v2-1-5a273153354c@amd.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901-gmem-selftests-fix-v2-0-5a273153354c@amd.com> <20260901-gmem-selftests-fix-v2-1-5a273153354c@amd.com>
Message-ID: <apbphZSNG4KXUNyW@google.com>
Subject: Re: [PATCH v2 1/4] KVM: selftests: fix maxnode arguments in xapic_ipi_test
From: Sean Christopherson <seanjc@google.com>
To: Shivank Garg <shivankg@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Jim Mattson <jmattson@google.com>, Peter Shier <pshier@google.com>, 
	Ricardo Koller <ricarkol@google.com>, Ackerley Tng <ackerleytng@google.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Sep 01, 2026, Shivank Garg wrote:
> migrate_pages() syscall expect maxnode to be one greater than the
> number of bits in the nodemask. do_migrations() passes the size of
> nodemask in bytes to migrate_pages(). This sets the maxnode to 8,
> so kernel only checks node IDs 0-6 even though the nodemask covers
> node IDs 0-63.
> 
> Pass the nodemask size in bits plus one because get_nodes() in
> mempolicy does --maxnode.

Ok, I'm not crazy.  I read all of this multiple times and the manpages seemed
completely nonsensical.  Looking at QEMU's use of mbind(), it's the kernel that
sucks:

    /*
     * We can have up to MAX_NODES nodes, but we need to pass maxnode+1
     * as argument to mbind() due to an old Linux bug (feature?) which
     * cuts off the last specified node. This means backend->host_nodes
     * must have MAX_NODES+1 bits available.
     */
    assert(sizeof(backend->host_nodes) >=
           BITS_TO_LONGS(MAX_NODES + 1) * sizeof(unsigned long));


And from https://lore.kernel.org/all/63ccc890-fd57-118b-5997-e0259f507d28@suse.cz:

 : And this is I think the reason why we can't change this now. I assume
 : numactl allocates 1024 bits (0 to 1023) and passes 1025 to make sure all
 : 1024 bits are processed. If we change it now, kernel will process 1025
 : bits (0 to 1024) and overflow the allocated bitmask. If it happens to be
 : at the border of mmaped vma, it's a segfault...

This is quite possibly the most confusing syscall interface ever, and IMO the
manpage is still straight up wrong (well, the kernel is the one that's buggy,
but the manpage doesn't reflect the kernel's behavior):

 : The maxnode argument is the maximum node number in the bit mask plus one

Beacuse it's not the maximum node number plus one, it's the number of nodes in
the bitask plus one.

What a confusing mess.


> Fixes: 678e90a349a4 ("KVM: selftests: Test IPI to halted vCPU in xAPIC while backing page moves")
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  tools/testing/selftests/kvm/x86/xapic_ipi_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
> index 469e3ab16460..0f11f4d7cc3d 100644
> --- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
> +++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
> @@ -291,7 +291,7 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
>  		 * KVM_CREATE_VCPU ioctl. If that assumption ever changes this
>  		 * test may break or give a false positive signal.
>  		 */
> -		pages_not_moved = migrate_pages(0, sizeof(nodemasks[from]),
> +		pages_not_moved = migrate_pages(0, sizeof(nodemasks[from]) * 8 + 1,

BITS_PER_TYPE()

However, given that it's basically impossible for developers to get this right,
we should add "#define MAXNODE_FOR_MASK(mask) (BITS_PER_TYPE(mask) + 1)" with a
big comment explain why the code looks wrong.

E.g. patch 3 gets it wrong in get_numa_mem_nodes():

  static inline unsigned long get_numa_mem_nodes(void)
  {
       unsigned long nodemask = 0;

       /* Get set of first 64 numa nodes available */
       if (get_mempolicy(NULL, &nodemask, BITS_PER_TYPE(nodemask), NULL,
                         MPOL_F_MEMS_ALLOWED))
               return 0;

       return nodemask;
  }

because that will only get the mask for bits 62:0.  Even Sashiko got confused in
patch 4:

  When maxnode is passed to kvm_get_mempolicy() here, the kernel must write at
  least 5 bytes to return 33 bits of node status. This rounds up to 8 bytes (two
  32-bit words).

since the disaster of a syscall that is get_mempolicy() and friends will only
provide 32 bits of node status.

Looking at the rest of the patches in this series, the main goal of fixing the
extremely-unlikely-to-happen-in-practice bug in patch 4 needs a lot of work.  To
move along the other cleanups, I'll send the below plus rebased versions of
patches 1 and 2.

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 2233d871a38f..cd5df88bc642 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -80,7 +80,7 @@ static void test_mbind(int fd, size_t total_size)
 {
 	const unsigned long nodemask_0 = 1; /* nid: 0 */
 	unsigned long nodemask = 0;
-	unsigned long maxnode = BITS_PER_TYPE(nodemask);
+	unsigned long maxnode = MAXNODE_FOR_MASK(nodemask);
 	int policy;
 	char *mem;
 	int ret;
diff --git a/tools/testing/selftests/kvm/include/numaif.h b/tools/testing/selftests/kvm/include/numaif.h
index 29572a6d789c..84e82857f1c5 100644
--- a/tools/testing/selftests/kvm/include/numaif.h
+++ b/tools/testing/selftests/kvm/include/numaif.h
@@ -30,6 +30,16 @@ KVM_SYSCALL_DEFINE(mbind, 6, void *, addr, unsigned long, size, int, mode,
 		   const unsigned long *, nodemask, unsigned long, maxnode,
 		   unsigned int, flags);
 
+/*
+ * Caclucate the @maxnode param for the above syscalls given the mask that will
+ * be passed to the kernel, to account for a longstanding off-by-one bug in the
+ * kernel that isn't properly documented in the manpages.  The manpages say
+ * that @maxnode is "the maximum node ID plus one", but the kernel's actual
+ * behavior is "the number of bits in the mask plus one", i.e. "the maximum
+ * node ID plus two".
+ */
+#define MAXNODE_FOR_MASK(mask) (BITS_PER_TYPE(mask) + 1)
+
 static inline int get_max_numa_node(void)
 {
 	struct dirent *de;
diff --git a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
index 469e3ab16460..1ddcf95d7fe4 100644
--- a/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
+++ b/tools/testing/selftests/kvm/x86/xapic_ipi_test.c
@@ -248,7 +248,7 @@ void do_migrations(struct test_data_page *data, int run_secs, int delay_usecs,
 		delay_usecs);
 
 	/* Get set of first 64 numa nodes available */
-	kvm_get_mempolicy(NULL, &nodemask, sizeof(nodemask) * 8,
+	kvm_get_mempolicy(NULL, &nodemask, MAXNODE_FOR_MASK(nodemask),
 			  0, MPOL_F_MEMS_ALLOWED);
 
 	fprintf(stderr, "Numa nodes found amongst first %lu possible nodes "
