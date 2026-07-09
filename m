Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91143A9DAE;
	Thu,  9 Jul 2026 05:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783576682; cv=none; b=YddUP8a2pr9rFKMOg/MyC2f99sDdR8C9wsWnbNb2E/qdB3+GhycOuey9AQ6+FZD613pUh3HVbg+LKCnxk3mxvYfHgSXF3R4Zsk0G4WORusZFweecaxK02CoZB4HReToaFD8yxTGnxHgbwaYPEObio8ziSRON5xhn2P6fjb6ji6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783576682; c=relaxed/simple;
	bh=gE/pHNbx547YCQoActu6Ay3E6ZtMNlssx50Pc9LWjuM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=o3m3q8/CTmoGF0FASd/aS13FlID0fxvZqVMd/33rNPp0lj7aUcLFedofhQ5ipQNK/ZcUUm25RkpKirft2MP8IcvmgB890qqVsH62QadSGhoJ3nL7F/ul2NfpmOWCKFHOCjv1Fzm1jT11Y44/igxdX6ESwBeMs73r++AzP8xpvZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V5Tn6BZJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V5Tn6BZJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 607271F000E9;
	Thu,  9 Jul 2026 05:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783576680;
	bh=xf5NQPRm+PlThVUYalodcm0x+VRuVBSqRkIVWGLY/XA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V5Tn6BZJLkxVItaPfGtZTeio2YPQv0sF8JqMvvYBNPsA+qPaNDRenlKs/s836974k
	 qsTr8puf4xA6xFW00rVJXpAh43IXBail89YZzVeuxVqk817zVGM84AHJD+nZfh+GYX
	 5j81OJNXC8mbtvk/6gsvMKN/LQHLh/65mbf2rYmw=
Date: Wed, 8 Jul 2026 22:57:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: rppt@kernel.org, peterx@redhat.com, david@kernel.org, ljs@kernel.org,
 surenb@google.com, vbabka@kernel.org, Liam.Howlett@oracle.com,
 ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org,
 seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com,
 aarcange@redhat.com, sj@kernel.org, usama.arif@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kvm@vger.kernel.org, kernel-team@meta.com, kas@kernel.org
Subject: Re: [PATCH v10 14/15] selftests/mm: add userfaultfd RWP tests
Message-Id: <20260708225758.0c8bcf16598f82d84ea7f71f@linux-foundation.org>
In-Reply-To: <20260708111417.173443-15-kirill@shutemov.name>
References: <20260708111417.173443-1-kirill@shutemov.name>
	<20260708111417.173443-15-kirill@shutemov.name>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed,  8 Jul 2026 12:14:15 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:

> Coverage for UFFDIO_REGISTER_MODE_RWP and UFFDIO_RWPROTECT:

I'm getting selftests build errors:

uffd-unit-tests.c: In function ‘uffd_register_rwp’:
uffd-unit-tests.c:624:25: error: ‘UFFDIO_REGISTER_MODE_RWP’ undeclared (first use in this function); did you mean ‘UFFDIO_REGISTER_MODE_WP’?
  624 |                 .mode = UFFDIO_REGISTER_MODE_RWP,
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~
      |                         UFFDIO_REGISTER_MODE_WP
uffd-unit-tests.c:624:25: note: each undeclared identifier is reported only once

<etc>

Seems that tools/include/uapi/linux/userfaultfd.h needs updates from
include/uapi/linux/userfaultfd.h?

I'll disable this patch for now.
