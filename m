Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB73E39447C
	for <kvm@vger.kernel.org>; Wed,  3 Jun 2026 07:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472520; cv=none; b=DD61hSIHA7Q5QP5eKgyDlCQJ28+MVrFmjeoZn5+KI7MRW4O0zWkSl8SVJoOYdWQgqy8IMOCS8WVFw1MLXLRcH4vyc/otYE/1dRaGxpBsZzbmn4Soamx4GSqmOV1y8DOD/2y16Fl6QprY+fS93hVWtburDq2YQus81Pj/ULzHeQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472520; c=relaxed/simple;
	bh=ImWSAjhqH1vXiUDpTQBJJbxyz0+cOWphGLgh+cdlhsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czYHTE8dAEW+mioMkItLhdBXqgkmYM274doxxQ0jcaAyZuicF9rJpS8eqAwGV6jVeIzZvxlTH/QgEMIo6fIyK4QMVjf3TZklD6GseZMWVIl2z/txDO4HZW8H8LTGTIAyNhNhCP2LUYmk6TGklLPBS9ZVq+733FCabXoEoWAikHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ep7dnyWo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ep7dnyWo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518271F00893;
	Wed,  3 Jun 2026 07:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780472519;
	bh=iIWCNeOlHWpHrU2XHMhyzU74jL/SRw5S/1AXW3LPs8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ep7dnyWouDjL/Gn6Tf8Rq5/PT6yyvwKIYN20BdfZFBICgvzu/eidLkIF0BUsvW3bE
	 2rTck0ybwwSahYByvROtHbc/iYbIwMQexrOIZmLiAv32KfxqUqmL2NcgG1PkkXkINx
	 tZelfbNBXCdDogSP9fCiMcfK8oxW80bYfk+4NuvN8YW89xEp1pTxXbfnLWuCDYwdkc
	 /ogqCuOjgq42xDiDIgsgpeTZGOfVIG7yg83pQebJJRtsg9NnS+s6FtRNMhIxT8N1jR
	 NccMD27gpNfG8IqWQjqblUCP40RbZifCeHwa2OjDiNQhIelAqvCG/WRsYF0ambufj8
	 H3HRLYvLRkeKA==
Date: Wed, 3 Jun 2026 00:40:35 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
Subject: Re: ppc64le kunit test failure: guest_state_buffer_test
Message-ID: <20260603074035.GA1148188@sol>
References: <20260603064225.GC18149@sol>
 <87ecioyt6y.fsf@vajain21.in.ibm.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecioyt6y.fsf@vajain21.in.ibm.com>

On Wed, Jun 03, 2026 at 01:03:09PM +0530, Vaibhav Jain wrote:
> Hi Eric,
> 
> Thanks for trying and reporting this. This kunit test depends on
> availablility of Qemu commit 5f7d861e("spapr: nested: Add support for
> reporting Hostwide state counter ") [1] that was merged in v10.0.0.
> 
> Since you havent mentioned the qemu version used I assume its a version
> < v10.0.0 . With the qemu patch available you should see this test
> passing with results similar to as originally described in original
> cover letter of the patch series at [2] that introduced this kunit test.
> 
> [1] https://gitlab.com/qemu-project/qemu/-/commit/5f7d861e65d90e0446b8f22a0bc859a5d8058ea6
> 
> [2] https://lore.kernel.org/all/20250416162740.93143-1-vaibhav@linux.ibm.com/

Nope, it fails even on the master branch of QEMU.

- Eric
