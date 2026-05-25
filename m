Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E0D7E0E8;
	Mon, 25 May 2026 19:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779737471; cv=none; b=Dd9+ZmX+pcuICMpNZb19OjipsDr/ylnk2bX+ZVQWCW0to7BioIPI6B3aOSP4LeRlV8Ukf8q2gjaXckYb2ksMWuzWQ7jOS7Ptzs1NYMWBZIu50XuhqHKFWYnf5QRCBT30e9xzO4JXscqsggKAJxaBgNRPKgOaIW2P0sHBQJ2BkiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779737471; c=relaxed/simple;
	bh=N8gKdsAi0eTXOEj0ow9BrIHwETIymwpVPAEdei5eMLk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uAhCVusHDDiJP7RMvPmycIn+BuTjYhoMtJnbciKo1KnOCk5OVMydNsT80rbFVIlufBoTU38E7zLechmd3M0mniZ9EDQf29qUfBPXUzVHPya2r8QgmR42WLJvmx5vg4NXSPGNEYYK/BbS5DpUy3LuShrxivryRxrxyRrrgvYWFfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CiwsqtlS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CiwsqtlS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC72C1F000E9;
	Mon, 25 May 2026 19:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1779737469;
	bh=QvrEoRjjhq9hE4z0e/L8Y7gfSYwRsEYYg3744tOFPOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CiwsqtlSv5tLtltiP4np3cPPoXXu+ECJba3j5uIoAsOrZwr1PKr2Io2fOFRsFVGbj
	 sNOM6allwT3Ub4CpsT3bHF7ez01xQ60dt2dY7DIdIZU+YashBqk0aLBV2JXYaT1SJo
	 AVofEgKXf7njpIj9jFN0NIytr2OWDcVqwi99jS/E=
Date: Mon, 25 May 2026 12:31:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: sashiko-reviews@lists.linux.dev, kvm@vger.kernel.org, rppt@kernel.org,
 peterx@redhat.com, david@kernel.org, ljs@kernel.org, surenb@google.com,
 vbabka@kernel.org, Liam.Howlett@oracle.com, ziy@nvidia.com, corbet@lwn.net,
 skhan@linuxfoundation.org, seanjc@google.com, pbonzini@redhat.com,
 jthoughton@google.com, aarcange@redhat.com, sj@kernel.org,
 usama.arif@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@meta.com
Subject: Re: [PATCH v4 03/14] mm: rename uffd-wp PTE accessors to uffd
Message-Id: <20260525123108.0b66d07c4be97dab3536dfde@linux-foundation.org>
In-Reply-To: <ahRf00RTI4_0Puux@thinkstation>
References: <20260525113737.1942478-4-kas@kernel.org>
	<20260525120513.C51E91F00A3A@smtp.kernel.org>
	<ahRf00RTI4_0Puux@thinkstation>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 15:43:32 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:

> To: sashiko-reviews@lists.linux.dev

hm.  What's this.

Sashiko seems to have been useful this time around.

> Confirmed and pre-existing ... Will address in a separate
> patch on top of this series.

There are quite a few like this.  Would it be better to address these
existing issues immediately then base the new feature-add on top?
