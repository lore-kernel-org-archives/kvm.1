Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793112712;
	b=5gU8ma7pXinEUbhlJ6Mtak+7nd1Wg2t3VlMOXAQrIOrIs92RtUfbW3MRIAT8IhCNPJdY
	 gTt1759/vjxPyZqMMhMR/Ub/WIVYTm0N7Zvzs68F4YW0GxQRp5Iphc/nSZquGbI5rAmty
	 mSvZQD7qICn0sCON3qe64lhQqaUxuBaNdOUY7EgHLBprc3eKIo9aDyejLOjkHeOxVdBL8
	 iUsONiUea4OvaoWbeWLr3us8OjKsC/6Gd9lYJxGNcM6lw/vKi93h0qo80UNDUPcmALT0W
	 IWVQNncwryyweeHuPtbkYrkemRiZgfkOaNq/r13R5iiviIKm9v/oUBNqSdMqmOFlfeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112712;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=JoOqvyAj0+Jgjt+c2q64ZVpxp84DiEqBDr/qWbcE/6Q=;
	b=gl5zJe4q2GY1YnHShxmgtLEt8K0QhgNW6j2Uix/EGnpAu2nR+B3ogUPEHfM9pBF1Oi/s
	 Od0cLXAAn+9/J+QSSrU0ZVOFUVqyNjRI1scVcXB+CT33ALirtTvJ7PO4wWtFbLZ1wVf6f
	 QmmlfmQAfD4cdxnfuh2iUM5MmeBi0eyZwHB/DQMiwBDHKmdqfaqWvakJ2sl1HKMNALn38
	 QrUqaxBaPvKsbOFw/PXcI1FXdBCPmAJmNpnwhV7aLdiJwK5KrTSEFD2oo42QjiNQJP71f
	 kRo6yvagdhH9ehqT5kTCq3bEiKeZH3naoApqF5IiVsNVijJibBiD6IBmGOyudl18UVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=az4lEek2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA49606A31B
	for <kvm@vger.kernel.org>; Tue, 27 Oct 2026 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=az4lEek2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F541F031E5;
	Tue, 27 Oct 2026 14:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793112711;
	bh=JoOqvyAj0+Jgjt+c2q64ZVpxp84DiEqBDr/qWbcE/6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=az4lEek2XZaQvbtwT/js8IRwBNgkl2479NPzwhFVN//obZR3z3zbbiUTdI83cibmn
	 lhlHU/NMSDCWNPKVwHA2RhwSm5NU19g1rT89n/pVplKXWBYvrKHRjTIfFJqK23Obw8
	 0Q0fpMzlY7hmAefyfeXKPrZwojDSGOdQq62pdlJlVIYxXiHxS1MPJyBO8wTZFgmXCB
	 HB/K00P4XAt8ZJND776NrElFPSpcFa2Xq7SyCn5MUK0yZ65yBVGtalX+BEt6uS4eBB
	 /t1nZMo7C7FQj6EdWsUZbtd1vM4z5ff5OHId/0Z+p4o4I9fam+WF4FPEcrbnq80Ytq
	 vAXX+WDtn8GUA==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 5D75A198004A;
	Tue, 27 Oct 2026 10:51:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 27 Oct 2026 10:51:49 -0400
X-ME-Sender: <xms:gLrgavLAlgkrAhj-6GVk5yLjUj1kyaDiq3PHRAuB8g5hZtL3adnBMA>
    <xme:gLrgahq9Ns9x_c8FHLAL2iQ29lp-hr92Bw2cw2gpp6xFzPUbsAt_MgBkpxcEL9Qso
    VTCqJC2qCdFPNYFJk1IFe7oQ3ugipZgsgosd87cO1r_YL9q7BICvRYm>
X-ME-Received: <xmr:gLrgaigHnEu2DOyJCpY49eTeuHuI1p8TjWFQcr3g-i1UMc-y-AQAr1B7orc>
X-ME-Proxy-Cause: dmFkZTGhb5CCIEhi8YRVlZWXxywwjLDCiGKJTqYq3TGxohkiie2e7b08prnm6qm3Mgq/Xv
    f8mSL32tsLRpmgHaz6MZN+ZLdDrreydc6PdATZZoDlZZ4l4PoJjiJdhSudk3RV1jcJLsWl
    oGA9pKowkapDelRVuYlxCWlLeI7Z9/5iCynDokopMlVbGp8TOM3/RjSN/h13nNEROePlRY
    T35FzV8bgHo+mgJ1f+5oYNw35uJOWghFaZlb9xVnbDVCacqulVDS82UMGOBzg1yx5ECtZJ
    FuUQ2k/l29twYFlZP1ht6lfqh9RlJqn8qcxxQSBg1/mtGcYkOI8JiYt70URezpQ7kmjRmV
    J0aWJh/2p99Q5+2naRg9TcLhY7jPBYo2JWuKgkFL8E4JXBF2S0D8yAS+GGxhVRrDOgc9BC
    sMOKD8Wl7RYrMPEiZQOpn9PekBFgU7capm2o7nIlInu72F6Xp1aDS5bdkZpG9R5GaJJCR3
    56gL0cSDcpTgU9GBjEaKbu1mje0wR7SzmSZEBZumtk18Yekozk9oGPdB9y5v/ze1OYIaSX
    tF8S/frgaX2ZSwZSJSxf4Jsr8L8G6idJw06leYWdZ26CGTfqBOijN+PT0bh+d3bnyy3g2n
    92jz6sAl2//Fv0Kppx7hFvHhS12BccSJOh2PGA7gOFwihsIfKg8mLHvpsSFg
X-ME-Proxy: <xmx:gLrgaumHM46mCUBbbnYEqXur4opZmpmG4YXo5V15tjjpYM-Mc85uPg>
    <xmx:gLrgah49HVzBmPghZOLcaa4hCoPYdU3q6YoMMqHVA-Q7u2TyKQg52A>
    <xmx:gLrgaim0om9HQc7lD6Tc-7i8r87HAvGK3UN41DOa8xgFZ_UxpPTy2Q>
    <xmx:gLrgajiZQVCrpJT1ZH2Qks2KtrpGxe2s57jSA7H7IlInRy3VksMJAQ>
    <xmx:gLrganlsr6aI5eIKIEcQYttuzXZA1Q_Yq5sz8KY9RTMvBvSmQ70WtJOR>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 10:51:44 -0400 (EDT)
Date: Tue, 27 Oct 2026 14:51:43 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Peter Xu <peterx@redhat.com>, Alex Williamson <alex@shazbot.org>, 
	kvm@vger.kernel.org, =?utf-8?B?TG/Dr2M=?= Molinari <loic.molinari@collabora.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 4/4] selftests/mm: test fork of PMD-mapped shmem THPs
Message-ID: <auC4eUEN52PJF1bM@thinkstation>
References: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com>
 <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-4-66f00b7a564c@virtuozzo.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-4-66f00b7a564c@virtuozzo.com>

On Wed, Oct 21, 2026 at 10:36:03PM +0200, Konstantin Khorenko wrote:
> +	/* The child's exit took the parent's share off the counter. */
> +	if (*after < own || *before - *after >= own)
> +		return FAIL_COUNTER;
> +	if (*after != *before)
> +		return CHANGED;
> +	if (mem[pmdsize] != (shared ? 'c' : 2) || !data_ok(mem, size, pmdsize) ||
> +	    !check_huge_shmem(mem, size - pmdsize, NR_PMDS - 1, pmdsize))
> +		return FAIL_PARENT;

ShmemPmdMapped is system-wide. A drop of 'own' or more from another
process between the two reads fails the test instead of being retried
as CHANGED.

The parent's THPs can also lose their PMDs during the test: reclaim can
swap one out, and NUMA balancing can migrate one, which leaves the
counter low while the migration entry is in place. That gives
FAIL_COUNTER, or FAIL_PARENT from the exact count in check_huge_shmem().

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
