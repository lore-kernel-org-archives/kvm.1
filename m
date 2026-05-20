Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D75A26FD9B;
	Wed, 20 May 2026 05:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779256231; cv=none; b=CDzyr9kRtz2ZrKhB0C3vma88pE+ht8aGJv7OnGS+86R7KvdUQFX6I10VVV76WuGO0Z8UUCMZJs+s7qgHICaq/rOPCLVo2LRtgbLztLuXagO1pi1eDOr9PUQ7O+tAvwxvuHd957KJ2lX47uwW4tjVxQbQ46T5yWfymDskwdF+Aps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779256231; c=relaxed/simple;
	bh=utoZ5UjMqTUegota0+o6RsF42OsGP5+0+70JJkYexII=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VYRm8FzDxGdQAZQEgRE1SRsCzXNqpIhg3FhcJ72sY/dJmEu7r85/oKuFe96OnUd+skDI+bCLe/Sx2Qxej3C9WLgT6bL8Loiuc7pFBL5DHlPPGvKIMiWzCSBUFZXqJI9yQDjmOYsvZLUzdyXpcirMRvBQHnKfaLLN5Tfo23nhYwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=rVRDlnqW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rixowV8s; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="rVRDlnqW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rixowV8s"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4BC221D0011E;
	Wed, 20 May 2026 01:50:27 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Wed, 20 May 2026 01:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779256227;
	 x=1779342627; bh=LIcPIlNdJcnZVN+jol9++caKPd/qdC1bGgVu0dtIXOk=; b=
	rVRDlnqWhyeicIiafQ6lnILi6gRnAQIMAZPR/Q6nCUH8S+NYUO7jLXI0sOEfBnvP
	JCQZD9uksjmoX6k2fiRrMVxkVHskA9NNq8Wda/lDUyjSJfNgpqcn6nNCRpMUphKx
	f1uowz95YZuSUUQzX2AxDMEU7UhZniTeZ0kMeofjSvcxhXNlgIzdv5SmDIARimGE
	KKG+zlbvBcetf4vs0KdOh5V2b5Rqq8156cBcixVVSFx+gTYDl6fsdWm9uQc+k1uV
	i7rJdf5dsC3rHEYmSHYKjO0I46VYEbN2zgyBlZThMu6974lrk0HlYylFttdcHSnl
	6PIwKpuEQKEDsiwoQQ71fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779256227; x=
	1779342627; bh=LIcPIlNdJcnZVN+jol9++caKPd/qdC1bGgVu0dtIXOk=; b=r
	ixowV8sV3laig9ytfXd4yy3ddQ9Ivw0zk25O0fx7/kadrkbTuA+pGnANhiT1dNte
	bSgnhNkmA6E062sid4z77pvL3/wtpF9kZGW02koQtIiO/8WhKLDS+vvwD/W7HA4q
	aMixDW8boJtqpnXKN0yU8uKbPUZP9l60S7Gvbu6Fxebby2LhQ7ppr/GMHaI4g47C
	K9bSct0AYyaYl6eNXKMbF9ONAY5i62kE/JblJzI4vlY3662w141gItHwD7JOgUWm
	8qxKdiHk3B5qEBaO4m+ozUNAE2Lpbsk00Rfl3raAmszNztfmoHzhc9Qgy8fRYeka
	ugxo0kq7SqCt5a+5LXxvw==
X-ME-Sender: <xms:oksNakmM4JVQlbdmVKVOraUOShfqCDRT921YI9cZUUYUXZsR0-u43A>
    <xme:oksNauokgAtESdLhuP5yPZ9H2aiiD4PvLZw2Nn3g2u2DF3gZD24IP2-qToFvyKchX
    W4KrEtp1V2ZyLhUjDISvOcPSqEkVly-aBrLRdZrLC2C8O4W1hnKshw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprhgtphhtthhopehmihgthhgrvg
    hlrdhrohhthhesrghmugdrtghomhdprhgtphhtthhopehnihhkuhhnjhesrghmugdrtgho
    mhdprhgtphhtthhopehthhhomhgrshdrlhgvnhgurggtkhihsegrmhgurdgtohhmpdhrtg
    hpthhtohepshgvrghnjhgtsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrrhhnuges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsvghiuggvnhes
    lhhinhhugidrihgsmhdrtghomh
X-ME-Proxy: <xmx:oksNajZExJMgWPruhnaMuk9WOv2RRghVdcFpSqKvv122qh-gk6_GmQ>
    <xmx:oksNajwmvFdUzkr8b_uXV6OXRF0QN7bpOHgCfKQI0RF7w_57zX2mCQ>
    <xmx:oksNavPufEjU3tLmH-4qITfuiD8csdXgPu9cH3RPymeAEq-e9TPDUQ>
    <xmx:oksNah7G2iH0KpZdxwavx0zDB-GwUOprx51OzISxM0tJcC_PXTItZg>
    <xmx:o0sNanrk5W4_CzMvW72_czH5Pk9os8DSFSyUXvKLmP0U70pi1g7VZHRP>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DD7F5182007A; Wed, 20 May 2026 01:50:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AE4mVO8kVrvc
Date: Wed, 20 May 2026 07:50:05 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Sean Christopherson" <seanjc@google.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Paolo Bonzini" <pbonzini@redhat.com>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "Alex Williamson" <alex@shazbot.org>, "Steffen Eiden" <seiden@linux.ibm.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Tom Lendacky" <thomas.lendacky@amd.com>,
 "Liam Merwick" <liam.merwick@oracle.com>,
 "Michael Roth" <michael.roth@amd.com>, "Nikunj A Dadhania" <nikunj@amd.com>,
 "Maxim Levitsky" <mlevitsk@redhat.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <f27f2ca3-2c82-4bd2-b270-34ccb0d081ab@app.fastmail.com>
In-Reply-To: <agzVorbOnlwczjP-@google.com>
References: <20260519202851.1339906-1-arnd@kernel.org>
 <agzVorbOnlwczjP-@google.com>
Subject: Re: [PATCH] KVM, SEV: fix merge conflict
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, May 19, 2026, at 23:26, Sean Christopherson wrote:
> On Tue, May 19, 2026, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> A conflict between two patches leads to build failure for
>> the reference countingg in 'struct kvm', which moved into
>> the kvm_refcount structure:
>> 
>> arch/x86/kvm/svm/sev.c: In function 'kvm_lockdep_assert_sev_lock_held':
>> arch/x86/kvm/svm/sev.c:118:32: error: 'struct kvm' has no member named 'users_count'
>>   118 |         if (!refcount_read(&kvm->users_count))
>> 
>> Resolve this by changing the added reference the same way as
>> the other ones.
>> 
>> Fixes: 422c363f58a8 ("KVM, vfio: remove symbol_get(kvm_get_kvm_safe) from vfio")
>
> This isn't a merge conflict, it's a bug in wherever this commit is coming from.

Right, my mistake, it's from a branch that is not in linux-next
yet, and I did the merge myself.

Sorry for the false report.

     Arnd
