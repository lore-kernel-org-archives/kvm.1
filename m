Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29AF480355
	for <kvm@vger.kernel.org>; Thu,  4 Jun 2026 14:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584155; cv=none; b=BDrBDF7i9EQKPIFr41CmoUV3H+/Gj15wpJlPxNvBoIMnBlrHwwYHisu1Vlhb9eGWhEl5eoGGovnTruT0muH5XTiG7joSkaObDxfgIRdmTWd6G6vAoIpQlRzntNu3J22ZzDSGot/Ns2AdGXFRFf2D7BPY1GNCqBA7CsS1jC3+lr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584155; c=relaxed/simple;
	bh=+trEsoBJ7qqHJUncXWC/1jVw2JZyXFrF5ArCWwQAVEA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O/Vc6Pwisza2FJEPyH1xRnPtTD0/S6kzmAmf902MGFxkBf76+PDMwLyyT5e1J+5bvkWXHKaynIx3/2/t9QpYM+AbjYYvXV0/wKbx51uFZEIfQzG13fmE+tIfWOV5MA+z22a5lCeJpO2ZrfLMSlkNsSYe73EREG+iBJUSuS+DB7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9WOe1PX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9WOe1PX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857031F00893;
	Thu,  4 Jun 2026 14:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780584153;
	bh=e6q7Es5Kp0zR6Jf64bblD8Qp7A0x16LixP59RRuZtxM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y9WOe1PXfInrq5pK9WM+v64Igy66jA/xXXC15I27oMd6mQ4Sj12vVgH6tojAGUTFc
	 5QIcvTyuvELMvtOnm6iAGDoo7SfZ0a0GNT6B+K479DfsR3n17mKdBtISQ9ABhy3SMo
	 ZVr2Pfc6QnM5/QP6t7ZQpslHrRYmQvQ4UrtkUUChEwfsSST0/gaIGGPnS+RUa1QQ6q
	 qZQfeiMirc+5d0agjjy9+73ubiLlcP7AuHX2C7VgTvg0URPkD7WIa6iciYOVNLnBvd
	 szaHpmGFu+zQgeCiWlEFxuI+ogKDctrz08pAfpymP/sHv/YYZcaPoPGmZliKbFRdJK
	 61sG69nyWufLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] KVM: selftests: Add a hugetlb memslot alignment
 test mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jinyu Tang" <tjytimi@163.com>
Cc: kvm@vger.kernel.org
In-Reply-To: <20260604142602.3582602-3-tjytimi@163.com>
References: <20260604142602.3582602-3-tjytimi@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 14:42:33 +0000
Message-Id: <20260604144233.857031F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Moving the memslot GPA by `guest_page_size` breaks KVM's host pa=
ge size alignment requirement when `guest_page_size < host_page_size`.
--

commit 6f87612dbda5d8765dabde103b78b45366d2e3b8
Author: Jinyu Tang <tjytimi@163.com>

KVM: selftests: Add a hugetlb memslot alignment test mode

This commit adds a -u option to kvm_page_table_test to intentionally
misalign the test memslot GPA by one guest page. It creates the memslot
aligned and then moves it to create a deliberate HVA/GPA offset mismatch.

> diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/te=
sting/selftests/kvm/kvm_page_table_test.c
> index fc5242fb956fc..a910e3abb8c71 100644
> --- a/tools/testing/selftests/kvm/kvm_page_table_test.c
> +++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
[ ... ]
> @@ -276,13 +278,22 @@ static struct kvm_vm *pre_init_before_test(enum vm_=
guest_mode mode, void *arg)
>  	/* Add an extra memory slot with specified backing src type */
>  	vm_userspace_mem_region_add(vm, src_type, guest_test_phys_mem,
>  				    TEST_MEM_SLOT_INDEX, guest_num_pages, 0);
> +	region =3D memslot2region(vm, TEST_MEM_SLOT_INDEX);
> +	host_test_mem =3D region->host_mem;
> +
> +	if (p->misalign_slot_gpa) {
> +		TEST_ASSERT(is_backing_src_hugetlb(src_type),
> +			    "Memslot GPA misalignment requires hugetlb backing");
> +		TEST_ASSERT(guest_num_pages > 1,
> +			    "Need at least two guest pages to misalign memslot GPA");
> +
> +		guest_test_phys_mem +=3D guest_page_size;
> +		vm_mem_region_move(vm, TEST_MEM_SLOT_INDEX, guest_test_phys_mem);

[Severity: Medium]
Will this move operation fail on hosts where the guest page size is smaller
than the host page size?

The KVM_SET_USER_MEMORY_REGION ioctl requires the guest physical address to
be aligned to the host's page size.=20

Because for_each_guest_mode() iterates through configurations that can have=
 a
smaller guest page size (like a 4K guest on a 64K ARM64 host), adding
guest_page_size to the aligned GPA will produce a misaligned address for KV=
M.

Could vm_mem_region_move() fail with -EINVAL from KVM in these cases, causi=
ng
the test assertion to fail? Would it be safer to shift by the maximum of the
guest page size and the host page size?

> +	}
> =20
>  	/* Do mapping(GVA->GPA) for the testing memory slot */
>  	virt_map(vm, guest_test_virt_mem, guest_test_phys_mem, guest_num_pages);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604142602.3582=
602-1-tjytimi@163.com?part=3D2
