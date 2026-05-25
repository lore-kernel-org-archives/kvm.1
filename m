Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F173F0AAD;
	Mon, 25 May 2026 14:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779721165; cv=none; b=hu7DV29FCkNhILEhEJjrVNGcj6Xd2/LzgaLsTbYqdYzIf1sRMq7N7+3yxptoPWtaKVR3okBM/ndQRfuqSVexSKVio7CJTAKjGHyzQxeetNKPg/LDf3AGZyYooQUwuX1AMfGtjm98dTN0wI0RzYN1gZ0WEuOrNoH2iNR/4kdhZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779721165; c=relaxed/simple;
	bh=YVXwQzIoY/wXq5rs8CcKCqJ+aVYa5J6G3wPF7LCWrYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIfDy+Yt9ANxtcTNsuUGVNPBR2tLDyYlU/ZEXyzUlRrowJ/GERgM0KICEyqXCyl5l6i0jaG7KoZPQfB1NvZKEPIrCL/uTQTPzoq3xxjHqXjFKnoqUUlS9YGulwq8STzd5gErKCfRV35LwonLT9iAXR6ksk0nFmoKC2knYIpciLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=vzODRWIS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=edH8wDyi; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="vzODRWIS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="edH8wDyi"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 9F1451300501;
	Mon, 25 May 2026 10:59:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 25 May 2026 10:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1779721161; x=1779728361; bh=uJcyea8FszbnWyZPO7/4y9oaI+nlsbVb
	Ye4HMnYbIek=; b=vzODRWIShDzqA2wIcanGpJjCOSLV0zb9pet4DC9Ngq8ac6p2
	EtRWyExyg5r1EPANRwYi+Cmtdj0xF066RV7zD78EJriD3VB/X/FoleJHxI3iM5xo
	dyGNx8Kz6kcCOn6KTfK79b+0lVKGPHuVsXSsFYhRRHHHxjJgU1Is0R8tdycP9bTs
	okPZkunGcY+2T9w8wVksOyt93fHsMNDuYotBgLAW2LcFilmGFuKUMP0klj3kOMr6
	T+aUvD6ZAnYqARdUmFXOwqyZAJgpgLLjo6qY8O6LHXCIuKkIyZDgANuxPIVK7kNe
	O8SzRDwEkX41kPAjKQLsXxY4oaNfemUzJZ4QZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779721161; x=
	1779728361; bh=uJcyea8FszbnWyZPO7/4y9oaI+nlsbVbYe4HMnYbIek=; b=e
	dH8wDyiN0V03aE/crXn9cpYOuiAAgTAh4FIR7PiKIN8RRYz/y5wfcdaS8QuOkXIc
	JjNQwSmnBJCH/a0iEmGedYI+UC3QJMf4ZFx9qZ1Xtkr4mkLtPRReoF6C4dbgFTmc
	o2/4jKKpfqrlakSra6decTnHEZvoolwMur+Hxd7zt12x3GwUqTqFljBQqKWk6fuF
	S2eoyfROjqFMlk0SvsT97RuoT+3SnrgV470mitd8KhMXLtWeumBUliVZ5F94LyTV
	/G/4Fawxwzwqe+wxCZhmDOncF+S4gC5FiRqIwdFINBlPbXgcnaOfEKzTKnMpPLqu
	3TEZCBBvAO/Oirk2ik6mQ==
X-ME-Sender: <xms:yGMUatWE-s3RE-Hp68zN3HHktCxPq9yYqYEEtgBSVRa19kCFSdY-QQ>
    <xme:yGMUangylZLSTfnZ8W0BCB-Hau68xSs7jcGysLCIYrEHzJxH0YehCLT6lLe6djvN0
    sm4n1wLs2_7rmxKuahzPtXggtLXZuEpCuETBT9nUClUkKpfeiuNRg>
X-ME-Received: <xmr:yGMUarRWXSM2yk9J4cSt3WbcJJ_wMTPNWbTtXX_vA5X93jEnWt6QW4USl-awLw>
X-ME-Proxy-Cause: dmFkZTEJjh70p+L5wV/erRevkiyg6otcc/PUgcMz5jGp00GqFmwb5PGsDGSnx1zvtQTsHV
    8kti811nWnmu3JFkW/YEZvGLc5svfAyVr6hjJNw1Q+INNTQIq8gztfZ97xuF5KzE+f1/rF
    ocRemqt7YDEj32fZ+jKcTb088tE323WwLDIfIQUN/KOpr5jv/734Ph88g8UQuAGGQtT5E3
    zNP0glrwHgjHLOijKqVUCr2AolVr1e0oHOFEP8Vp4GaHZ/KNa2CjbX0aUspnArEFdBsXeY
    oza4f1wStmf7SlgWO9qWSc7040wZajc7Fys5l5jE+HMsxm01vVUyHACUyjUYXYN4QixCSj
    cQ6FBhsxOalHc4v/dYw5N0tQ20D3WQDQKaBI5KoEHe0efKgRKGZ8f3rqXGjnCE1gG5eNFg
    85TsuHbfKBueOei65zAPMuoGY9hLqEgeIQkHxznyb0r8u13SEZ7Mnd0W9hW8EVzvNbgu6G
    zT2XcmLw54RVbjuWqJPP+ol0xcrcgndbETKiOnW0SHzmpVCrRBEY5SykxUbxSGhjMD8B3l
    ISWe72k4h4wiQDjZ4R5GlwUdy4mWSeICpB2Z9VhONd7R+oBKkb7fP8iCtSdMzLlUU+lLrO
    zOj5YIGLychZMnXMjMWKdu4hBkZUgvmbZXr0/ob5cfqMwYSoVHxC2AgLdVdA
X-ME-Proxy: <xmx:yGMUarwhm8ZlX6TSjpbE9A7BLn6tCpnrNYVaST4bjO_ODXUvhXiJjQ>
    <xmx:yGMUag8lCLv3xmxGk4kmyD42l7wp7ClAfpZ1MHK7IYgaPvXfyuarkA>
    <xmx:yGMUatYoJo6DGzSk9u4ZVUvxKVyXa8zdxH6KlNkjdWuovXbw8JRzwA>
    <xmx:yGMUat6JqEMmcVrovhF86sU72wR015nVrX7dIgkjNlkBEGyZSP8tRw>
    <xmx:yWMUaj44x6uj0QdlIxMfh8b8Qk5bcka_CNnXBdsAC1LznnD9RZHYQdJP>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 May 2026 10:59:19 -0400 (EDT)
Date: Mon, 25 May 2026 15:59:18 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: sashiko-reviews@lists.linux.dev
Cc: kvm@vger.kernel.org, akpm@linux-foundation.org, rppt@kernel.org, 
	peterx@redhat.com, david@kernel.org, ljs@kernel.org, surenb@google.com, 
	vbabka@kernel.org, Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, 
	aarcange@redhat.com, sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v4 04/14] mm: add VM_UFFD_RWP VMA flag
Message-ID: <ahRgKh8kZJ8z-huA@thinkstation>
References: <20260525113737.1942478-5-kas@kernel.org>
 <20260525121916.831DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260525121916.831DA1F000E9@smtp.kernel.org>

On Mon, May 25, 2026 at 12:19:16PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [High] VM_UFFD_RWP is missing from VM_COPY_ON_FORK, causing silent
> loss of read-write protection during fork.

Already there -- include/linux/mm.h:

#define VM_COPY_ON_FORK (VM_PFNMAP | VM_MIXEDMAP | VM_UFFD_WP | VM_UFFD_RWP | \
                         VM_MAYBE_GUARD)

> Pre-existing issues:
> - [Critical] Evaluating __VMA_UFFD_FLAGS causes a stack buffer
> overflow on 32-bit architectures.

The VM_* values for the high-numbered bits (VM_UFFD_MINOR,
VM_UFFD_RWP, VM_SEALED, VM_DROPPABLE) are all gated to VM_NONE on
32-bit, so no 32-bit VMA actually carries bits >= 32 in vm_flags. The
OOB the bot points at is in mk_vma_flags() constructing a stack-local
mask, writing dead bits into bitmap[1] of a 1-long temporary -- no
consumer reads them. With __always_inline and constant bit indices
the compiler should fold them away, but it's still UB.

Pre-existing -- UFFD_MINOR (41) and SEALED (42) already have this on
master, RWP just adds bit 43. Worth a follow-up cleanup, not blocking.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260525113737.1942478-1-kas@kernel.org?part=4

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
