Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6131C221F2F;
	Tue, 21 Jul 2026 02:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784602712; cv=none; b=aw00VHt3KZ37P8xZD9nKlPtu46x1IOUw8ubmbA8IXg8GPpTljnJs0U/ytYKfg1OTal6Co8BACjs1bb/wZutoaVVcBZw36hRT7h5abM38VDKJbvWakX0bW6pn+CRQCLVHM7AdQ2VRphqPgHhAFKO9qxCgxlJll/wHOOCU5eWRGVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784602712; c=relaxed/simple;
	bh=zzgSUL2w2pJxmzWtm+3a9SPbUU/HksYkPEFYH1X66kY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fG0jZnytR2yp/CLXkxWwWcCSCJZ9xgOKQWfHo2qe6HONeqFF+scCi9DhetHYEFbMwJ34JCkVb0I8tO5ynrTk5V7/kxIqm6gSa9h9yGVcoBjomRjyudJt+THtmf2Gwp2KQ2Mj/bDmHHB3p0cfxX5NPQ1HH48qHmiAVCGVBw27Bkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyERwKYT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyERwKYT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EB8A1F000E9;
	Tue, 21 Jul 2026 02:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784602710;
	bh=FL5CGqbLgWSEbS6kX734MNF4vL+ica3pHW37Hpl8AN0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=kyERwKYTLGFrgKgWOI9Srcy0pa69D+lYq4aGOgCb+o9EepqVCmYaAvZkH2plHKIaT
	 HKX6X1FiajmP3qBoGVkcU1ZHDTq9ykYdyGObzrscFVBxKXk56t0R0kRAz0vNnhqIkH
	 2aRNjb0y8aCCXvmll4XtUQ7CwUcgNMce2pQG7Fg/CwI7Gy86IwXdu+tfnzLrbAXjEE
	 gTBepq6wImyG8lBkJrPRX+YGy+xPoANzxsymbytflXjPG/YXfeOwCZYBu13n8D6u+w
	 XMB61aLfl32u/e3uQ5OeHZcQsjF7OsFbyPHK7za4tY7Ggh227SnUV6wjtBMmQs+R4P
	 25Sqe0fQzgpRQ==
Date: Mon, 20 Jul 2026 20:58:23 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: "Dylan.Wu" <fredwudi0305@gmail.com>
cc: palmer@dabbelt.com, pjw@kernel.org, aou@eecs.berkeley.edu, 
    anup@brainfault.org, alex@ghiti.fr, atish.patra@linux.dev, 
    zhouquan@iscas.ac.cn, linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
    kvm-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: ptdump: Move pagetable definitions to common
 header
In-Reply-To: <20260701085030.124579-2-fredwudi0305@gmail.com>
Message-ID: <3bb2f519-c70b-6c35-c404-6fbfe8adbeb1@kernel.org>
References: <20260701085030.124579-1-fredwudi0305@gmail.com> <20260701085030.124579-2-fredwudi0305@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Dylan,

On Wed, 1 Jul 2026, Dylan.Wu wrote:

> Move the pagetable walking state and level definitions to a new
> arch/riscv/include/asm/ptdump.h header. This allows other parts
> of the kernel (like KVM) to reuse the ptdump attribute parsing
> logic.
> 
> To support different pagetable types (like G-stage), the attribute
> parsing logic in dump_prot() is updated to use attribute bits
> defined within the pg_level structure rather than a global array.

Could you please split this into two patches: the first, to create 
ptdump.h and move the declarations there and export note_page(); and the 
second, to make the attribute parsing and structure changes?  That will 
make the changes easier to review.  


thanks 

- Paul
