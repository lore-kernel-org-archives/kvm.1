Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C0D30E84B;
	Sat, 23 May 2026 10:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779532665; cv=none; b=Ii9ZmtgWfzaH3k0DNUMQBPFpLPKk7DOCCJrHFaEfjyHUTXNFMqHvy98Ca+BxUpkAv4LaxJssQkjfRttLJXKlXlnq4GZMWz2RJRsORVWQAsZDbgPaN6UAI4BWqm5Yw70jbBcqtCUQOFntrwIGMz2FemKVqAng0i9R39dC9kawljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779532665; c=relaxed/simple;
	bh=g3+TkRRALb7IhqgZxnCIVq3fxis7ltyRAflGA13FOwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVlUGqVRfVMwGdIsMSpYSjIpP0Yxdk+yusf54JaKM2WdQW32RGcPAbWBWicQT35PgnZ79u9XUa8jtdHcWP9pgiH5XTv4ygtDhsz06saTJlvmCWBL623UISJkccaeR+gbLh0jEbBk6G2Y4posi+ZjfBSG7wUffNXNvM37aaQd3uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0DTuPMg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0DTuPMg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528391F000E9;
	Sat, 23 May 2026 10:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779532663;
	bh=snoJupCrLvennL6uXOgnTKfm9IRgKoBXu8jeUzQitF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=h0DTuPMgVw6ksHlRqsKdtZnAHmn75iWnceRWOcNotrmKw4hDEFmI2/KnVEeRPdQ6c
	 KcKkk6IvsHktG1+/3vB3xCzYnAD7ZWefqvPi+fdJQwylvxcvYJVzyhKNEPTnNqSxcc
	 uvTNe4fRermhbk1PE1RFRFEsDZi7BhO2RJS0gxhvKtaUo5Mu/ePY5INY860CkxoD1I
	 TBz6tBohMupfZFlw2TiQ5cWvD2hLGUrdc/2aj7PfKm3glTII1Mgq3X0jdw+fKnfHF9
	 NwXKA8cPubvWH38wPXJmN4IBhYFriKrmq+PWseVlMhu7GWnwTdbqpjMpx/opGXhcYB
	 xir9qwzGvHf1Q==
Date: Sat, 23 May 2026 13:37:32 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, peterx@redhat.com, david@kernel.org,
	ljs@kernel.org, surenb@google.com, vbabka@kernel.org,
	Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net,
	skhan@linuxfoundation.org, seanjc@google.com, pbonzini@redhat.com,
	jthoughton@google.com, aarcange@redhat.com, sj@kernel.org,
	usama.arif@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
	kernel-team@meta.com, linux-man@vger.kernel.org, alx@kernel.org,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: Re: [PATCH v3 15/16] userfaultfd.2: Add read-write protect mode
Message-ID: <ahGDbKr2u6sqoc3f@kernel.org>
References: <20260522133857.552279-1-kirill@shutemov.name>
 <20260522133857.552279-16-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522133857.552279-16-kirill@shutemov.name>

On Fri, May 22, 2026 at 02:38:56PM +0100, Kiryl Shutsemau wrote:
> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> 
> Read-write protect mode (UFFDIO_REGISTER_MODE_RWP) is supported starting
> from Linux 7.2. It traps every access -- read or write -- to a present
> page within a registered range. The matching UAPI consists of:
> 
>   - UFFDIO_REGISTER_MODE_RWP   registration-mode bit
>   - UFFD_FEATURE_RWP           capability bit
>   - UFFD_FEATURE_RWP_ASYNC     async (in-kernel) fault resolution
>   - UFFDIO_RWPROTECT           install / remove RWP on a range
>   - UFFDIO_SET_MODE            runtime sync/async toggle
>   - UFFD_PAGEFAULT_FLAG_RWP    new pagefault.flags bit
> 
> Document the new registration-mode entry, the "Userfaultfd read-write
> protect mode" section, the new pagefault flag, and a VERSIONS line.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> ---
>  man2/userfaultfd.2 | 147 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 146 insertions(+), 1 deletion(-)

This doesn't apply to the current man-pages tree
https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git

and reading raw groff hurts eyes too much.

What linux-man tree did you use to generate those?

-- 
Sincerely yours,
Mike.
