Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889013090D4
	for <kvm@vger.kernel.org>; Wed, 24 Jun 2026 00:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782260550; cv=none; b=GOFewE5KMJ8vm5qnX5tFC1TCYtNkKXhRB5PeEq/N0Tv1OjyOYeT5kiAK+W0ifw88jSGGJQW6fsD6dt48PpEQqyYbwpkvf2CWieMTTYNQlgFcRzXvxh4SYDn082eA7v73rnbd8FxCyjdMqyWtZnUCvszrQLKO5HHuICdP/txDrSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782260550; c=relaxed/simple;
	bh=Im9ECNA/eYIfWvEnwDlvKxOP+T1hR/JutMkL7WyGA3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CwyjcYxpqwTcYwzZmBJ6ftZCb6Yt7oGpQbN+5rjBbXLxaNBPksUkjl4AXRx7JVqP6qY7RZQm3PYims+6O4P9EVS66G1LQIUv+mkqhk1ghU4A2qdqX9IQv2n2ELcyashCZtFnsK/+9p/PCnljnoKXjVpmMJDWSDWbLB/XeEN7xGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wCTQ3Hkj; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wCTQ3Hkj"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c6afd85980so3412045ad.0
        for <kvm@vger.kernel.org>; Tue, 23 Jun 2026 17:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782260548; x=1782865348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x/nmkXtxC655eN/Fa1UpO0NEZu89XwXtuz155IpCbkE=;
        b=wCTQ3Hkj/EoymT+6eZsZoKi6jDDxzl8e4q7G/ZLRv0LPgDULZ+lKGCRM8KMLnrczkH
         34QjJib5K09knFAaRX4ShCDk/QFoociXMpgqQU0r7CHj39v2pwDVXpaIUZwbt8eow5bM
         LNu7mh6KSTGMQExpNbau0n9HbZ+WeEDOg0gEMSBRMnFh0F0L6NaHSh5JgLIHJF4l2Rv3
         Mp6GhqW+czOoe70EU0CrC341BlxHKZX5+lbWDEHDUTuO3o3xjiXAPOd9w4WmshWg3tqT
         t/MkyH0r2z8Rf9ruV8rXxL69R0IrwzGowyJAy7+dN8QcZJ8OMMxMy7comaj7ArJsx5tk
         JZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782260548; x=1782865348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x/nmkXtxC655eN/Fa1UpO0NEZu89XwXtuz155IpCbkE=;
        b=DK+HKHlM9mQRtxuYvNAkv0aGj2FG41JrKxZXp4jThr3OEaXttZs9OWM+Yi/aCmgKY6
         nrAMQoYoTt4PRUmFdXbtmzuIZ1q2m7EHuUGKdRfiUNFQ6fqd1LPL0gWH0GuYJpSxMJam
         j4Mws5qwDGC0ahC3YE9RZavDulUA5DaaUXw/WBduyxJVptOy9rvXvjgoBWL8FghDPpX/
         CQEa4qacKVr28siilkHZY6/eJ6XfSB2FeAOOnYJg8XmAQnDNLhHj+CcZdpTOAvNU28ov
         0As3UhBLM1ZpSTwHwx7JfiLvJ6CWxbzUBuZJfuZIve6Lp3hxC2hIgPnnT9qom77y/5aP
         UXoQ==
X-Forwarded-Encrypted: i=1; AHgh+RpBykV0ExzrjhHhV0y09sfIAh07dgNVgxrJ+IhtV8wFpvwEdek13nzAHlKLUVAI/UtrwW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBkSDvksoL99Ta0d3k8iO0vzveCawwycimQSfF5iFg1hBGYVNH
	xABRRqS5nRA7gIY4bWUyZbGHjlFzVfuNTtDLoAvA/rijmW2LVwEIy6zpf1ZowiyK/+9GrJL4EDM
	TI//4aw==
X-Received: from plar15.prod.google.com ([2002:a17:902:c7cf:b0:2c6:c4ac:778])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f60e:b0:2bf:281c:d2d3
 with SMTP id d9443c01a7336-2c7e13f04c2mr11942625ad.9.1782260547507; Tue, 23
 Jun 2026 17:22:27 -0700 (PDT)
Date: Tue, 23 Jun 2026 17:22:26 -0700
In-Reply-To: <6xyh7xa53k2s7bytlkcys4pyq4756rwoly5q7swrifv3td6dey@3h5e2e67lkvj>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260501203537.2120074-1-seanjc@google.com> <20260501203537.2120074-3-seanjc@google.com>
 <ajNQ_Ix5e0p6FuFT@google.com> <tx3hcnrhfbcz2p7e7umc5o2zrw74pluzuzgtlqt4dz5cc5nhxx@6tzzorc25nqw>
 <s7jfbw3tnfgmp6blfqlfoi7yhq6f5n6xl62zzty5up45cqtsty@ljpjlvqw2gyy>
 <ajrkryMxHZtsMvga@google.com> <6xyh7xa53k2s7bytlkcys4pyq4756rwoly5q7swrifv3td6dey@3h5e2e67lkvj>
Message-ID: <ajsjQtpZb-h2BdPh@google.com>
Subject: Re: [PATCH v2 2/6] KVM: selftests: Add a test to verify SEV
 {en,de}crypt debug ioctls
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 23, 2026, Michael Roth wrote:
> On Tue, Jun 23, 2026 at 07:55:27PM +0000, Sean Christopherson wrote:
> > > From: Michael Roth <michael.roth@amd.com>
> > > Date: Mon, 22 Jun 2026 22:47:03 -0500
> > > Subject: [PATCH] Revert "KVM: SEV: Allocate only as many bytes as needed for
> > >  temp crypt buffers"
> > > 
> > > When SNP is enabled, the data passed to firmware must be contained
> > > within pages that have been transferred to firmware ownership via the
> > > corresponding RMP table updates. 
> > 
> > IIUC, and I'm pretty sure I do at this point, this is wrong, or at least *very*
> > misleading.  Nothing in KVM performs RMP table updates, and so saying "the data
> > passed to firmware must be contained within pages that have been transferred to
> > firmware ownership" is completely inaccurate.
> 
> The driver will place it into the 'firmware' state ("5.3 Page States" in
> SEV-SNP Firmware ABI) prior to issuing the command to firmware, so from
> a kernel perspective I don't think it is inaccurate. It's true that this
> is handled transparently to KVM, but I don't think the wording is really
> in conflict with that.

Ugh, I didn't even consider that possibility, obviously.  Well, TIL.

> Just trying to clarify and understand if I'm missing something more subtle
> here, 

Noped, I simply didn't realize snp_map_cmd_buf_desc() and
snp_populate_cmd_buf_desc_list() even existed.

> since your proposed fix seems nicer and more complete anyway.

It's missing a case though :-(

The final write for ENCRYPT writes to the destination directly:

		r = sev_issue_dbg_cmd(kvm, __sme_set(__pa(buf)), dst_pa,
				      nr_bytes, KVM_SEV_DBG_ENCRYPT, err);

More at the bottom.

> > Piecing together the changelog and diff, and my own observations, my understanding
> > is that **firmware** modifies the RMP to *temporarily* take ownership of the page
> rmp_mark_pages_firmware() in drivers/crypto/ccp/sev-dev.c does the RMP
> table update as part of preparing the command buffers prior to issuing
> the firmware call, placing the page in the 'firmware' state, and once
> the command completes, firmware modifies the RMP table state to be in
> the 'reclaim' state. The page will still be 'private' at that point, in
> the sense it will have the 'assigned' bit set.
> 
> The hypervisor can then take it back via additional firmware call
> SEV_CMD_SNP_PAGE_RECLAIM and subsequent RMPUPDATE to normal/'hypervisor'
> page. So the transition out of 'firmware' does sort of happen
> automatically, but the overall reclaim process requires explicit work by
> the hypervisor.
> 
> > while performing the {DE,EN}CRYPT operation.  So there's no requirement that the
> > pages be in any specific state, the only "requirement" is that software needs to
> > either prevent concurrent accesses or be prepared to handle spurious RMP #PFs due
> > to the temporarily RMP modifications.
> > 
> > SNP_DBG_DECRYPT does require software to convert the destination to be a firmware
> > page: "The firmware also checks that the destination page is a Firmware page."
> > But this is about SEV_DBG_{DE,EN}CRYPT, not SNP_DBG_ENCRYPT.
> 
> The above behavior isn't really specific to DECRYPT/ENCRYPT, but one
> example of a general requirement that when issuing legacy SEV commands
> on an SNP-enabled host, the memory that firmware writes to must undergo
> the above transitions before/after the actual firmware call:
> 
>   5.3.9 SEV Legacy Commands
>   The behavior of the SEV-legacy commands is altered when the SNP firmware is in the INIT state.
>   In this case, the SEV-legacy commands require any page that the SEV-legacy command writes to
>   be a Firmware or Default page.
> 
> ('Default' state is for ranges that have no corresponding RMP table entries
> at all, which isn't really applicable for how things are implemented in the
> kernel currently. The reasoning there though is that those pages can't be
> used for SNP guests, so legacy firmware commands can't be used as a widget
> to try to mess with private guest memory).

Oooh, got it.

> SNP_DBG_DECRYPT calls it out explicitly since that's how it as always
> worked, whereas for legacy commands these are additional, SNP-specific
> operations that happen before/after the legacy commands, so they are
> documented in a broader fashion.

Thanks Mike!  I appreciate the info, a lot!

> > > This is not compatible with uses kmalloc() allocations since kernel accesses
> > 
> > As is the statement about kmalloc().  kmalloc() of a PAGE_SIZE is a-ok, because
> > the kernel will always hand out a full page.
> > 
> > > to other allocations within that page will trigger an RMP fault and crash the
> > 
> > And it's specificaly about other *accesses*, not simply other allocations.
> > 
> > > host. Fix this by moving back to page-based allocations.o
> > 
> > Always forcing full page allocations is overkill for SEV and SEV-ES, and robs us
> > of the opportunity to document that SNP+ is special, which is especially important
> > because AFAICT, none of the specs are so kind as to document this "minor" behavior.
> > 
> > Rather than fully revert, just force PAGE_SIZE allocations if the host supports SNP.
> > I haven't run anywhere near 14 hours, but I was also getting failures on every
> > single run of the test, and I ran the test 100 times without problem.
> > 
> > However, this only addresses the case where KVM is using temporary buffers.  For
> > small, nicely aligned operations, a misbehaving userspace could induce a crash by
> > coercing the kernel into accessing the to-be-{de,en}crypted page via a kernel
> > mapping while the crypo op is in-progess.  I don't see a less awful option than
> > forcing KVM to use the "slow" path, e.g. if the problem is limited to the dest
> > for a decrypt operation:
> > 
> > diff --git arch/x86/kvm/svm/sev.c arch/x86/kvm/svm/sev.c
> > index 87025d0d2f91..7e3334c90c57 100644
> > --- arch/x86/kvm/svm/sev.c
> > +++ arch/x86/kvm/svm/sev.c
> > @@ -1406,7 +1406,8 @@ static int sev_dbg_crypt(struct kvm *kvm, struct kvm_sev_cmd *argp,
> >                 sev_clflush_pages(&src_p, 1);
> >                 sev_clflush_pages(&dst_p, 1);
> >  
> > -               if (IS_ALIGNED(src, 16) && IS_ALIGNED(dst, 16) && IS_ALIGNED(len, 16))
> > +               if (IS_ALIGNED(src, 16) && IS_ALIGNED(dst, 16) && IS_ALIGNED(len, 16) &&
> > +                   (!cc_platform_has(CC_ATTR_HOST_SEV_SNP) || cmd != KVM_SEV_DBG_DECRYPT))
> >                         ret = sev_issue_dbg_cmd(kvm,
> >                                                 __sme_page_pa(src_p) + s_off,
> >                                                 __sme_page_pa(dst_p) + d_off,
> > 
> > But if firmware temporarily converts *both* pages, then we're "stuck" because at
> > some point KVM needs to actually target the correct guest-owned page.  The only
> > option I can think of is to require capable(CAP_SYS_BOOT), *if* the above doesn't
> > suffice.
> 
> Not sure I understand fully, but snp_populate_cmd_buf_desc_list() in the
> firmware driver requires the transiton for the destination page that we
> write to both for 'encrypt' as well as 'decrypt'. What the issue with
> using a temp buffer as the destination for the 'encrypt' case?

The problem is if KVM does NOT use a temporary buffer, which is the "fast" path
where src, dst, and len are all 16-byte aligned.  In that case, KVM does inline
{de,en}cryption between src and dst.  But those pages are also mapped into
userspace (they have to be, since KVM pins them via gup()), which means that
userspace could feed the same pages to a different chunk of the kernel that
reads/write userspace memory via gup() (or gup-like equivalent).

E.g. pread()/read() on shmem-backed memory.

Looking at the full picture, isn't this a bug in the PSP driver that affects all
commands?  With pre-SNP VMs, "guest owned" isn't really a thing, since nothing
guarantees that the destination page is accessible *only* by the guest.

If we rip that out and always bounce-buffer, then KVM won't have to force its
own bounce buffering of sub-page lengths for SNP, and that would eliminate the
race I described above.

Completely untested (I'll give this a whirl tomorrow).

---
 drivers/crypto/ccp/sev-dev.c | 52 ++++++++++++++----------------------
 1 file changed, 20 insertions(+), 32 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 7cd6cd6fdb10..44c34c0e3f6f 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -528,15 +528,11 @@ static void *sev_fw_alloc(unsigned long len)
  *              replaced with the address of a bounce buffer.
  *
  * @len: length of buffer located at the address originally stored at @paddr_ptr
- *
- * @guest_owned: true if the address corresponds to guest-owned pages, in which
- *               case bounce buffers are not needed.
  */
 struct cmd_buf_desc {
 	u64 *paddr_ptr;
 	u64 paddr_orig;
 	u32 len;
-	bool guest_owned;
 };
 
 /*
@@ -582,7 +578,6 @@ static void snp_populate_cmd_buf_desc_list(int cmd, void *cmd_buf,
 
 		desc_list[0].paddr_ptr = &data->address;
 		desc_list[0].len = data->len;
-		desc_list[0].guest_owned = true;
 		break;
 	}
 	case SEV_CMD_LAUNCH_UPDATE_VMSA: {
@@ -590,7 +585,6 @@ static void snp_populate_cmd_buf_desc_list(int cmd, void *cmd_buf,
 
 		desc_list[0].paddr_ptr = &data->address;
 		desc_list[0].len = data->len;
-		desc_list[0].guest_owned = true;
 		break;
 	}
 	case SEV_CMD_LAUNCH_MEASURE: {
@@ -605,7 +599,6 @@ static void snp_populate_cmd_buf_desc_list(int cmd, void *cmd_buf,
 
 		desc_list[0].paddr_ptr = &data->guest_address;
 		desc_list[0].len = data->guest_len;
-		desc_list[0].guest_owned = true;
 		break;
 	}
 	case SEV_CMD_DBG_DECRYPT: {
@@ -613,7 +606,6 @@ static void snp_populate_cmd_buf_desc_list(int cmd, void *cmd_buf,
 
 		desc_list[0].paddr_ptr = &data->dst_addr;
 		desc_list[0].len = data->len;
-		desc_list[0].guest_owned = true;
 		break;
 	}
 	case SEV_CMD_DBG_ENCRYPT: {
@@ -621,7 +613,6 @@ static void snp_populate_cmd_buf_desc_list(int cmd, void *cmd_buf,
 
 		desc_list[0].paddr_ptr = &data->dst_addr;
 		desc_list[0].len = data->len;
-		desc_list[0].guest_owned = true;
 		break;
 	}
 	case SEV_CMD_ATTESTATION_REPORT: {
@@ -661,7 +652,6 @@ static void snp_populate_cmd_buf_desc_list(int cmd, void *cmd_buf,
 
 		desc_list[0].paddr_ptr = &data->guest_address;
 		desc_list[0].len = data->guest_len;
-		desc_list[0].guest_owned = true;
 		break;
 	}
 	case SEV_CMD_RECEIVE_UPDATE_VMSA: {
@@ -669,7 +659,6 @@ static void snp_populate_cmd_buf_desc_list(int cmd, void *cmd_buf,
 
 		desc_list[0].paddr_ptr = &data->guest_address;
 		desc_list[0].len = data->guest_len;
-		desc_list[0].guest_owned = true;
 		break;
 	}
 	default:
@@ -680,24 +669,24 @@ static void snp_populate_cmd_buf_desc_list(int cmd, void *cmd_buf,
 static int snp_map_cmd_buf_desc(struct cmd_buf_desc *desc)
 {
 	unsigned int npages;
+	struct page *page;
 
 	if (!desc->len)
 		return 0;
 
-	/* Allocate a bounce buffer if this isn't a guest owned page. */
-	if (!desc->guest_owned) {
-		struct page *page;
-
-		page = alloc_pages(GFP_KERNEL_ACCOUNT, get_order(desc->len));
-		if (!page) {
-			pr_warn("Failed to allocate bounce buffer for SEV legacy command.\n");
-			return -ENOMEM;
-		}
-
-		desc->paddr_orig = *desc->paddr_ptr;
-		*desc->paddr_ptr = __psp_pa(page_to_virt(page));
+	/*
+	 * Allocate a bounce buffer if this isn't a guest owned page, or if the
+	 *
+	  */
+	page = alloc_pages(GFP_KERNEL_ACCOUNT, get_order(desc->len));
+	if (!page) {
+		pr_warn("Failed to allocate bounce buffer for SEV legacy command.\n");
+		return -ENOMEM;
 	}
 
+	desc->paddr_orig = *desc->paddr_ptr;
+	*desc->paddr_ptr = __psp_pa(page_to_virt(page));
+
 	npages = PAGE_ALIGN(desc->len) >> PAGE_SHIFT;
 
 	/* Transition the buffer to firmware-owned. */
@@ -712,6 +701,8 @@ static int snp_map_cmd_buf_desc(struct cmd_buf_desc *desc)
 static int snp_unmap_cmd_buf_desc(struct cmd_buf_desc *desc)
 {
 	unsigned int npages;
+	void *bounce_buf;
+	void *dst_buf;
 
 	if (!desc->len)
 		return 0;
@@ -725,17 +716,14 @@ static int snp_unmap_cmd_buf_desc(struct cmd_buf_desc *desc)
 	}
 
 	/* Copy data from bounce buffer and then free it. */
-	if (!desc->guest_owned) {
-		void *bounce_buf = __va(__sme_clr(*desc->paddr_ptr));
-		void *dst_buf = __va(__sme_clr(desc->paddr_orig));
+	bounce_buf = __va(__sme_clr(*desc->paddr_ptr));
+	dst_buf = __va(__sme_clr(desc->paddr_orig));
 
-		memcpy(dst_buf, bounce_buf, desc->len);
-		__free_pages(virt_to_page(bounce_buf), get_order(desc->len));
-
-		/* Restore the original address in the command buffer. */
-		*desc->paddr_ptr = desc->paddr_orig;
-	}
+	memcpy(dst_buf, bounce_buf, desc->len);
+	__free_pages(virt_to_page(bounce_buf), get_order(desc->len));
 
+	/* Restore the original address in the command buffer. */
+	*desc->paddr_ptr = desc->paddr_orig;
 	return 0;
 }
 

base-commit: 53f2cae5efddf82a426a4e980fd3a2450c68aef0
--
