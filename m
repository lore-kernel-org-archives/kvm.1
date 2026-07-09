Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FA322A1D4;
	Thu,  9 Jul 2026 02:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783562764; cv=none; b=NXGq0TZHzz/RH8s9Ybo82AzHWQt8bSxQA5dvNYfMhrDcblhKuEXXqBpsAmP7/Prow1vTIY3wdvyC47NqssJiYqKi+lpAJxVqCgFIlyKvRQonGCeLHjJ8Hfe4M1sztkhmEbt9S2bNVaJoa0adomtucnjyXVsgKE3lwDdkAa7m65M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783562764; c=relaxed/simple;
	bh=4TBAMDs51nKjPI6X3lwgBRi/8vBA5L9Lw3sclcSgISA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tSf4sMsTKzoOAQzbxJazoW4/6FCKeRXSWZqnR0NeQYaqJy5deXw7D5ECLn7OOJOy8uZ1ODgyu2bav9XNp805da9zar5Npu9ZNdBl6nl2xa4uSk2KmdSfzMpML/xCbXPveIG1Srbfw54Rs3P84KDkaNOtxMnWfyim4Fmdo+9GGgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=a/aJCuzY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a/aJCuzY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154F61F000E9;
	Thu,  9 Jul 2026 02:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1783562762;
	bh=fh+v6z4LaKdRJWSZzxsh8LHRO9V5c51gNjIrY3QRuEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a/aJCuzY0fXm/KWEGb0ilP5jrAq0B6hvKMSkgZF/S+3aNzXAlEM+zvP2EW1L3RgZE
	 zgq824Y1pp9qiAXd+ySxZTv4GUka/BKpsKEfJxXJ/L0MKkruHAz4ya3hD1V92d4h0n
	 HrqEsUuKptmUc5gKMWuOyZHy4qA9CrrMuMOgRqGM=
Date: Wed, 8 Jul 2026 19:06:01 -0700
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
Subject: Re: [PATCH v10 00/15] userfaultfd: working set tracking for VM
 guest memory
Message-Id: <20260708190601.4cebdebf9d1f6e9aeebcb853@linux-foundation.org>
In-Reply-To: <20260708111417.173443-1-kirill@shutemov.name>
References: <20260708111417.173443-1-kirill@shutemov.name>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Jul 2026 12:14:01 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:

> This series adds userfaultfd support for tracking the working set of
> VM guest memory, so a VMM can identify hot pages and reclaim cold ones
> to tiered or remote storage.

Thanks, I'll add this to mm-new.

Sashiko failed to apply so let's find an excuse for v11!
