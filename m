Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561E13A5437
	for <kvm@vger.kernel.org>; Mon, 22 Jun 2026 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782123726; cv=none; b=ZnuLN8XxzfFMK/f5+8XYtI9ESNGvu2C76/Sav+UXdfuiIqBAm5WzXkp+ZZizOJRLruhDw9+GEoh1WQWkArmIsEvcr1nsqeHyAiKvmmEqRftkgGBbocgw7lQzOS0HHxoJ3usnc4ZyacXt1rqlEcxZBwEtPd0Dsh6P2LB694Udk/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782123726; c=relaxed/simple;
	bh=V36N5qqTK871HGmVbyRrv3qGLBId8ErFaP2QKthJkZs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jW6N0ZmqKFtDzlcHZNyQqXIvgO+DnXRpdlLVMsOyiAguWl1qKavLq6PPdUGa06m+8acVwfYP88gYfUAm7ksLv6jUYByGhbu2vyLpMZP4udRuWaScOHOgqURL42hECSrTMX2lj0Su9YcXAvshIos1IDAdztjdKmYVW/nI1aAXQ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AB1vYXDf; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AB1vYXDf"
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782123713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V36N5qqTK871HGmVbyRrv3qGLBId8ErFaP2QKthJkZs=;
	b=AB1vYXDf/UiXtxGrnGPRghKQiJYVCLUt6wcsjNkwxOm4gj1O0DUTcHuk+arNX5KrypiXwG
	aiGeHbofiEpJV/qmI0XglPUntPxViVk5FmgISyiQDSRTTnzeiQ4lVx/r+xUz1ZVvOgoIrc
	+Wzeap8md9knZmv7G0wnhUV3G3aHItY=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 10:21:47 +0000
Message-Id: <DJFI4P57YE9X.20DPMTK9LL7LW@linux.dev>
Cc: <linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
 <kvm@vger.kernel.org>
Subject: Re: [PATCH v2 06/13] KVM: VMX: Use higher-level allocator
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: <sashiko-reviews@lists.linux.dev>, "Brendan Jackman"
 <jackmanb@google.com>
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
 <20260622-alloc-trylock-v2-6-31f31367d420@google.com>
 <20260622101056.4120C1F000E9@smtp.kernel.org>
In-Reply-To: <20260622101056.4120C1F000E9@smtp.kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon Jun 22, 2026 at 10:10 AM UTC, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] The commit message incorrectly states that `__alloc_pages_node=
()` allows passing `NUMA_NO_NODE`, while the opposite is true.
> --
>
> commit 7bd439c242125db27305b61b14c9972fb028282a
> Author: Brendan Jackman <jackmanb@google.com>
>
> KVM: VMX: Use higher-level allocator
>
> This commit switches the allocation function used in alloc_vmcs_cpu()
> from __alloc_pages_node() to alloc_pages_node().
>
>> KVM: VMX: Use higher-level allocator
>>
>> The difference between __alloc_pages_node() and alloc_pages_node() is
>> that the former allows you to pass NUMA_NO_NODE.
>
> [Severity: Medium]
> Is this description inverted?
>
> Looking at include/linux/gfp.h, it appears __alloc_pages_node() explicitl=
y
> forbids NUMA_NO_NODE (-1) via VM_BUG_ON(nid < 0).
>
> Instead, it is alloc_pages_node() that handles NUMA_NO_NODE by explicitly
> checking for it and falling back to numa_mem_id().
>
> While the code change itself is safe, the justification reverses the
> behavior of the two APIs. Could the commit message be updated to
> accurately reflect the API semantics?

Repeating myself[0] as this patch has a different CC list from the others:

Sashiko is correct, the commit message says "former" but it should say
"latter".

[0] https://lore.kernel.org/all/DJFI39RWHV1O.MMMMMZSK8E8C@linux.dev/
