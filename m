Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2F526059D;
	Mon,  6 Jul 2026 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345968; cv=none; b=iJ/BT1Stgdx+amTdF34UdDxI0NNvzPTf6II5TjMmFFrOvQkSLrLKG4sckI0g4XOwQ0mfYREKOPZlNMti3iQtj0VuOZ1do5IVYGKT3Y0Ss2yQH+FDRua3QIA0DkNOKeh/5fp9lgSEoVhNO24uUM6H8ADG/4Vm5KZWmElHsIg8eOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345968; c=relaxed/simple;
	bh=LKXhWXt9sUO6TLuEba9phppj/eKqFtLPdIALoV4CA+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUIXqDS1puPB+Xiw4VytJpaF1Flnwr+1ZxqJrQs5DqyFA++vXEi24+MNiZI9BoQdLrJ6qrUYYAw00gkB32oxVVhL2y3pnnDY4iykHfuwD28Pw88izB7PIdKxJyOy7Ec01mKCX5PWU2A3ayGrTj86nLGE0nYQHxjPycqEdjKsjDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=ORGHdGOD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QUPbPPQq; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="ORGHdGOD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QUPbPPQq"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id E02861300141;
	Mon,  6 Jul 2026 09:52:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 06 Jul 2026 09:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783345964; x=
	1783353164; bh=4xSpkCs0mkVTU4ldegsUj6ukw+q9jYjeMqfDzWKa/Xs=; b=O
	RGHdGODYRzGGOQtsJDjFD/GHjYhFLrnwmhJ4nj8SQmbfwwqdnFLxvAhIIr2qmvYp
	OIgRR91nabhXx/M1Keia/pwrRMj4ezHDF1pPDv/TPJ0iJN1zmbCUTtZ7Fj14cbrr
	GrxddPQyqgMk4Z3UhbceLX5TFPJeZ4LzEzsRc744K14D9Oat0JWhaCdj9l4WPoK6
	LULyYorRKcoIQQZG8btIK8yDfvFkNPMNTmIDk2X+m8rop6JvvxlmudT1OVbcS21S
	p4c0S9TARY7ig36mYp6laIOveg6zBhWMD6wo2fQ5DFMasDBNGxnmU11Srj2S4y47
	WUsKMsLuSpJmHxeixAiKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783345964; x=1783353164; bh=4xSpkCs0mkVTU4ldegsUj6ukw+q9jYjeMqf
	DzWKa/Xs=; b=QUPbPPQqfSQuGc49n1E+EybiKQ0AjhWnTZMkKKrGMICkDTpo0tR
	5WFz4zimhqh01LY5oX8JF3dMQ+gxYjo01lD63mmV0TXQBPiaHD9FUybHVRzQdU6n
	rgmnU0mrORY6N2JknY9kOwW9ZwOTcsJhwDIDUJKfW5pkL4dDFE4vPXtrVKAX+GJ2
	9JPKFwB729Rt11z7ZWVnLfwlA4zicjPcR2hADg0AEvibY8ABCyBE7HGb1SMh24iA
	4mmrJjZ+/7mjWj1miTm5M29347jKnz/xMVzaC4w8TxX6BBkOwblSRkPmF9TLsVbW
	++X0uRlj9lSoe/9SBythXU7NSxnBUjj9zzw==
X-ME-Sender: <xms:LLNLanE6LlyrXVmKP3xTrqQNWWWCtGiC3IWD8qgp5wQoHwI0QCJamQ>
    <xme:LLNLapl7OV15UFWVChlyt3TySoYcuctjzYfJfzPueR5QcET2_Jnl4WVi4d3Ue42LZ
    Vz_tdKNIm7EIPRDLnKLvM4l7dCTr1I83fMy_wDcpnFyNLU9cyCmHUw>
X-ME-Received: <xmr:LLNLarxl3RmMbO80ftN88T98zlBaxjMIehNW5r49XbEXI7SE_Omrq0onUbJnVA>
X-ME-Proxy-Cause: dmFkZTFPCg2xwzQp7+TI1AOZhFkobdSqGL70wE3j5fYy6KqFBfnJe9khnAl2AW8p19ybla
    nOxVA4zszBab8zr8DAan3yxr5qDfbWaQ7hJ0NV7b2cJcr9Ntio7u6fMe/SZ1Ow14Pkh5HQ
    ptUJ0KggNDTKeDH4n/Q8AE5HDb09nHZevYvSsPVBfKaw3cVqEkr2CrDDSCUq1GTSqMO/aG
    6e/ngxiV+iKUWwq5+HTbtOtYYZzjntsgrIYdWQZizB+zForZNk1430IEoIqJTPzK7rMTXz
    j9+5K1gVmvaC34Ge54Wnv2ClsmAUX1jFs0jgre4VbvtAv67OuKOpOjIvce9g2h1Au+a7uE
    buz2uli7Do9QfqtwyDqctNlSu9PPCnpQXstgQalTDZQX97AGfYP7wxZCaGRmbH2gwAVA2X
    p14HERtrYr/w2iXgq6STldHNMj83l/I+f1XqVLD7zSDNK2GZhog1REBHU39JN//wV78I6Z
    12DjItb9i0hZohCsrTwCrTUhdt921TbetY78X4V+jjYkgRDselLlRCtF11IufQgniTyYjl
    RvUSAMyyOdKT1ZxL/5SaRZa94bHBD5DaXWbrmqbgb+T2/EJVJLSoGm+BEapk5py0GMhghP
    UgKUHY+7LrgPaDz+WRbfe6L3bZDgiwRKevb+1m3aDsdTKYdJ2+lTMcMJOS4w
X-ME-Proxy: <xmx:LLNLakxVwn-knlQW7wbVuPMHDMIKU8yy926Qd4EYpTMqG4dbHlXgrQ>
    <xmx:LLNLat8niT3RPiXgA6o2nvGAsuZaeIBLErg4ISpzTl6HCeMn7MGVzg>
    <xmx:LLNLanhmJdZS9kmbpZMRmxOmmPmpaCvJ0dxl1KoWKiJsSZEzoBRR3A>
    <xmx:LLNLagWrHJbS0-XoWcWwwboXd5ZUmXB2neZykJLtexUwM92w1WYwqg>
    <xmx:LLNLas3c-rN8K7N5YGo-PdiyItlVc3GSGJMIQzly137JJ3QVI0UjPaF_>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 09:52:43 -0400 (EDT)
Date: Mon, 6 Jul 2026 14:52:42 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Usama Arif <usama.arif@linux.dev>
Cc: akpm@linux-foundation.org, rppt@kernel.org, peterx@redhat.com, 
	david@kernel.org, ljs@kernel.org, surenb@google.com, vbabka@kernel.org, 
	Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, 
	seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, 
	sj@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kernel-team@meta.com
Subject: Re: [PATCH v9 11/15] mm/pagemap: add PAGE_IS_ACCESSED for RWP
 tracking
Message-ID: <akuy09U-g0AKSEfy@thinkstation>
References: <20260706084805.8400-12-kirill@shutemov.name>
 <20260706125726.729431-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706125726.729431-1-usama.arif@linux.dev>

On Mon, Jul 06, 2026 at 05:57:24AM -0700, Usama Arif wrote:
> > @@ -2443,8 +2443,12 @@ static unsigned long pagemap_page_category(struct pagemap_scan_private *p,
> >  
> >  		categories = PAGE_IS_PRESENT;
> >  
> > -		if (!pte_uffd(pte))
> > -			categories |= PAGE_IS_WRITTEN;
> > +		if (!pte_uffd(pte)) {
> > +			if (userfaultfd_wp(vma))
> > +				categories |= PAGE_IS_WRITTEN;
> > +			if (userfaultfd_rwp(vma))
> > +				categories |= PAGE_IS_ACCESSED;
> > +		}
> 
> The above is an ABI change for existing PAGEMAP_SCAN users although not
> sure if there is someone that cares. Would below be a better alternative
> to limit the ABI change?
> 
> if (!pte_uffd(pte)) {
> 	if (userfaultfd_rwp(vma))
> 		categories |= PAGE_IS_ACCESSED;
> 	else
> 		categories |= PAGE_IS_WRITTEN;
> }

You're right that it changes what PAGEMAP_SCAN returns outside a
VM_UFFD_WP VMA. I think that is the intent rather than a side effect --
the commit message calls it out explicitly as a UAPI narrowing.

PAGE_IS_WRITTEN is documented as "Page has been written to from the time
it was write protected". Outside a write-protected VMA there is no such
point in time, so the flag has no defined meaning there -- and the
current code sets it unconditionally on every present, non-uffd PTE,
which makes it a constant duplicate of PAGE_IS_PRESENT. A caller cannot
use it to tell written pages from merely-present ones.

Scoping it to VM_UFFD_WP makes the bit mean what it is documented to
mean. A consumer that read PAGE_IS_WRITTEN on a non-WP range was reading
a value that never carried write information, so I don't think there is a
meaningful user to regress.

And in the unlikely event an actual user turns up that depends on the
current behaviour, we can always switch to your else-form -- it is a
small change and keeps the old value.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
