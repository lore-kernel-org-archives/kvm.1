Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9B081AA8;
	Fri,  8 May 2026 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778261542; cv=none; b=S0/0075ESS5nlJt120T+22oevDBCEKg4p8XNJpKWatUCvDqEQsp4V9DbQiKqg1vfmN4adAFkf+75fOZQmdpg9eGOhp+yLEps1uY7qnZPlBWzTnahkwwqtr5TFqIz0WMeO6aRMN6/f583HWpR6AFMdv66mle10iHXdoKkAKXzeUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778261542; c=relaxed/simple;
	bh=hVPRSg/Aw0I1iOxX29ZJQVzFj0tLkTvJRdEgtd6gtFQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KOItpEaEQi++iBml158VTCUvu6sTIbB7c137AHq1vjujYGYbB9jTSDiumnVMLFwJ71a0r2xRwcaePHizM43nCAOd1X/lkWiHcAI+TA5Gw8VP/AFSpOetDJj60iBlmfwE1me0a76TMeoegyWVN3kHzV9mvWJMIp7manKR4ZSKlFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cIjwvtvU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cIjwvtvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36103C2BCB0;
	Fri,  8 May 2026 17:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1778261541;
	bh=hVPRSg/Aw0I1iOxX29ZJQVzFj0tLkTvJRdEgtd6gtFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cIjwvtvUImu7UJUAxjtcmuA/pRzJ7AAThBot1FXPvuxh/gq3FKF152tCWY9BcRscQ
	 IT5yOPpH7MAoFkpgf4gFE78JZcCSamL/xFz8GQl9Nw55LGdLBqwqk/VO3hvuyN0B5i
	 BaUT7wXFf6L1LOPx82+PG9GOWSD2vcRnthOL5zYQ=
Date: Fri, 8 May 2026 10:32:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: rppt@kernel.org, peterx@redhat.com, david@kernel.org, ljs@kernel.org,
 surenb@google.com, vbabka@kernel.org, Liam.Howlett@oracle.com,
 ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org,
 seanjc@google.com, pbonzini@redhat.com, jthoughton@google.com,
 aarcange@redhat.com, sj@kernel.org, usama.arif@linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kvm@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 00/14] userfaultfd: working set tracking for VM guest
 memory
Message-Id: <20260508103220.aa46427b6f4c5d0247d2afb0@linux-foundation.org>
In-Reply-To: <cover.1778254670.git.kas@kernel.org>
References: <cover.1778254670.git.kas@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 May 2026 16:55:12 +0100 "Kiryl Shutsemau (Meta)" <kas@kernel.org> wrote:

> This series adds userfaultfd support for tracking the working set of
> VM guest memory, so a VMM can identify cold pages and evict them to
> tiered or remote storage.
> 
> v1: https://lore.kernel.org/all/20260427114607.4068647-1-kas@kernel.org/

Thanks.  I'll duck v2 for now, await more review.

> Assisted-by: Claude:claude-opus-4-6

For my education, and perhaps for others: can you please explain how
you used Claude in the preparation of this series?

