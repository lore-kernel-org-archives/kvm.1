Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B91381E85
	for <kvm@vger.kernel.org>; Fri, 11 Sep 2026 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161606; cv=none; b=WyAMrHTVk0eHjyPbxUwFFsDofg7Jucuqw5jad6e8yh/XilsLGF1X6yWUCcf+Y+O04EFRvfq+OcG/k9KDCDUI/3p8AnbVPIUXai99ukE4b6LG/6Vf5eAt0Oj3aq7iTC+yf8EpI45QHg2CyJq/XkkVr+E4IMMUxaoTc29bTZY3Q0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161606; c=relaxed/simple;
	bh=bKVLpuJoXNHwkurAfi7UgD9lCJASDNSJJrNgYAvMuN4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUPrRKT3CoP/vOz2uEnpj1JJnSvp9egiWipFKfjVIMnffli7NMAe5xeTJGMqLsmjJmhq+rtlyv+O8vvvw12Ap1refJTa74xO3BKnsRzWpJdGDSKIF9LCpvF4Ha9FrpNZdVhPfhBNHmFJYgQi+1UZ9tkA/vzSImaHyjPXfouNrLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=F25l0PAc; arc=none smtp.client-ip=185.70.43.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="F25l0PAc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1789161599; x=1789420799;
	bh=TN80T40ot0fOX+gz/g52gag9IAPdBE4QeYKXbXMJkKU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=F25l0PAc9PDp6D7afJ/Qj7AsPldnfcWtkPgpsawP85w840NboXEImUboxrkBp8+Ve
	 P8y/XMj2CfEYlY4uVs+L2lN7uuYZvQbgdJRSczZJQpz6CvpfjT3xVjyGsPBgkhd83R
	 NzaN3HSHFGnB2eXUkTvc8BdusK6B0qPKgRqfwljN3eFhC6w1IbHpIhx83OzTdIBMWL
	 pIMHiEITcRCve8HOYNqabFn54syJeImIl6z/hYlTQo4U+o4U4vxeGaeZTNlXZBSCYs
	 xUDn0v9aZdBvmpOiGrDE2hezWwA6mt3mwTaAQUz8y0SVnBOzu0mzCeR48ZKGuTpUkk
	 utyhvwRnD2k3A==
Date: Fri, 11 Sep 2026 21:19:54 +0000
To: pbonzini@redhat.com
From: David Ballesteros <davimaba.v@proton.me>
Cc: kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/2] KVM: unbounded per-VM kernel memory growth via KVM_SET_MEMORY_ATTRIBUTES
Message-ID: <20260911211949.39247-1-davimaba.v@proton.me>
In-Reply-To: <20260911203238.30088-1-davimaba.v@proton.me>
References: <20260911184819.101123-1-davimaba.v@proton.me> <20260911203238.30088-1-davimaba.v@proton.me>
Feedback-ID: 219068424:user:proton
X-Pm-Message-ID: 3dbc4add1d65563f026f34bd62072c5533cca3d3
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Status note on this thread:

The report and this series were intentionally posted publicly from the
start (v1, 18:48 UTC today); the finding is AI-assisted, which per
Documentation/process/security-bugs.rst is handled as public.
security@kernel.org was copied on both.
security@kernel.org: dropping from Cc from here on, since the thread
is public and archived; your private copy of the report is unchanged.

Errata for the v2 cover letter: everything under "Proposed fix" below
the "Changes in v2" block is stale v1 text describing the previous
design (per-mutating-ioctl rescan, "0001-v3.patch").  The accurate
description of this series is the "Changes in v2" section and the
commit messages of 1/2 and 2/2.  "No change to patch 2" means no
functional change: 2/2 is rebased on 1/2.

One precision fix for the 1/2 commit message: "keeps every non-failing
ioctl O(present entries touched)" should be read as applying to the
counter maintenance and to clears; a set request still performs the
upstream O(range) reserve/store loops.

A range-diff v1..v2 is available on request.  The instrumented
reproducer used for the measurements (multi-VM scaling,
GET_DIRTY_LOG latency, clear-path bypass) is available on request.

David Ballesteros

