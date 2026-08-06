Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD452ED16D
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 14:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027800; cv=none; b=h4bC1gUg0gsc9iI4YKpMYSSGz+jpm/7wCkgQ6WxDydkIx1OcZM+giVyO1OaHoTu26PVQbxB0SvAvhtSXZS0t7UK4Tp+DWzeZ5pnVWCPZk942weoG/7C2pUVkLrlCvMCDAQ15b/8zMtqHKwPVFsKebcdzy2ABJMu54YaGNzexTUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027800; c=relaxed/simple;
	bh=GqWJbyEVh73CKamWJMKdCBl3gcMofKfofQ1I/xmCDaM=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=CtjUPOPa1sQh/jUrQEJtAwI8PyrjPeyENh8RMTXsxF85aiof6w39p352GmqWwEgBs+8wCuCwTXySbGB/iERFGJLalqM+Cias1MkjV49kVPK/9jMkj1izOT/GowItiaquK48RsQGz9eEY62BoBlxG53zSYms8XTeaTGzvChgOttg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=hcBwGkIM; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="hcBwGkIM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1786027785;
	bh=GqWJbyEVh73CKamWJMKdCBl3gcMofKfofQ1I/xmCDaM=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=hcBwGkIMNkUiZLypd2snnaW9l9WfqZcY3Zy6843461bPJBIkkJWkuxwe1+V2nsDvr
	 PWLTlkGx2pGSRUkB6Nu+T5VhHyUWRiNON19bHFokQo1tOtPeHUxrsI7nBy10zAKpf9
	 ilF+VgXPcGuocY5thcCkQNJ/qNN7x0o4bp5Lv1YA=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-XMAILINFO: MHyJd5qrf7Bou/+s5+cLNZUIC3Mexcip+BhoH12kdqXBv5zMr904GrjJqDuIzE
	 EUk7Uc7JpkESM7siUDIzSa/AWXRBRTtHazcC/He3XI85ygYOJt6/gLD+ClIpt4qXWhuBW2cdWlKAT
	 e4R1zWp4AqFPUUBp1rV2OQGSyBHwb64Jl8RDiWJVAw2nFZvYTB26Ttz1U4T02aMSdZRIw2O90sCoW
	 wZLMIO1aSLSZCcuCciDuD9q843CR4+6B2gxsq6ThUvP7cElftREI7zTL0e4/wm2tUlcu90OOrzKUk
	 OHkwt8O8AEwyIWxn0bu50chAjoZ6FKquTaDj/T15VZWU8TiX4V41JarvEuGNsom8Y03bpLVPR5Tbd
	 K9Q7pMKe2BysYDMy/HfEVLCgJzzcDvrm9w01bDRvmzr/+6bjXpXLkHd/3yLCoyjiJhuXgcHPY5A7J
	 vkdJDGQWJTFPD/So9Y6/kpzoTGsIXWcOit3CfRIK0Uaa5UQ3cPwmFTZCPry9usoBBFtIjt48FVZbr
	 MtIq4867UFzYZbLLYE1MDBoVRGBifalMUZuWrWB2tqwS4bCwzt2SOpaDMb/Kg5XlCcxxUG4Zbd2HI
	 Uozscpz23YFw2njHYrvhu1WuxM8p6E5KrN9JOLZtim/hu1wDzMTfRH0hUuomDq00bng4W7IDOQJKr
	 EqnF9yhpPOa6oibzkiWXzgVresdOPStoWalPmbgG22IecuwIiiSsAe3mx1vWnJbfaYEkNFSO314Xd
	 5du+rAidI4+YAFzQ84rJrZILtribggCLC6+0CMxPReKzOKTCGh8NUbWUG8BINyXCvJFfhGQOvnGl3
	 ZFc8T7isGM8Et9CSYTFB92xfqDr7rn2laAyZTscmBKEDr4Sksj/bQmZnDo4ztqPiSIx4GewxF1eVe
	 pYTjLyhXuOF/0wGPnMVFSk4Rv7IT63hlM2CL5MN+i38AdkvKHH3aIfxJ6CqR7WMaySdKInVtnAzL2
	 Wnz0+LZUZOXC7BHEIrnrWpKj0K1d94PMe5D+K7nVS1I9UOR9SCwNIaSmxcUQ7dma4S5Mdg70jhuhG
	 ldaUs/8bkwpVTEYEhpl/tAgOTUEtJeBcR9Vhi5Nv+V7wYDDoJ89oceVRrk4MHxtiHOG86ZQub30Xo
	 VVI=
From: "=?utf-8?B?U2hlbiBZb25nY2hhbw==?=" <grayhat@foxmail.com>
To: "=?utf-8?B?UGFvbG8gQm9uemluaQ==?=" <pbonzini@redhat.com>, "=?utf-8?B?a3Zt?=" <kvm@vger.kernel.org>
Cc: "=?utf-8?B?U2VhbiBDaHJpc3RvcGhlcnNvbg==?=" <seanjc@google.com>, "=?utf-8?B?VG9tIExlbmRhY2t5?=" <thomas.lendacky@amd.com>, "=?utf-8?B?QXNoaXNoIEthbHJh?=" <ashish.kalra@amd.com>
Subject: Re: [PATCH 2/2] KVM: SVM: Re-check enc_context_owner under the owner's lock in sev_vm_destroy()
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 6 Aug 2026 22:49:43 +0800
X-Priority: 3
Message-ID: <tencent_8845B9E8A3D61C1479584BE8072B41422A08@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_DDC4E4352EC91CAC05A9A8F4E55E8C96730A@qq.com>
	<e2c6f458-564e-44a4-9fb5-df774cd7ce92@redhat.com>
In-Reply-To: <e2c6f458-564e-44a4-9fb5-df774cd7ce92@redhat.com>
X-QQ-mid: xmsezc57-0t1786027783tsm9eemw3

T24gOC82LzI2IDE2OjMwLCBQYW9sbyBCb256aW5pIHdyb3RlOgo+IFRoZSBwYXRjaCBuYXJy
b3dzIHRoZSB3aW5kb3csIGJ1dCB0aGUgY2xlYW5lc3QgZml4IGZvciBib3RoIGlzc3VlcyBp
cyB0bwo+IHN0b3AgcHJvdGVjdGluZyBlbmNfY29udGV4dF9vd25lci9taXJyb3Jfdm1zIHdp
dGggdGhlIG93bmVyJ3Mga3ZtLT5sb2NrLAo+IGFuZCB1c2UgYSBnbG9iYWwgbG9jayBpbnN0
ZWFkLiAgVGhpcyBhbHNvIGZpeGVzIHRoZSBvdGhlciBpc3N1ZSwgc28gSSdsbAo+IHNlbmQg
YSBwYXRjaC4KCkdvb2QgcG9pbnQg4oCUIHRoZSByZS1jaGVjayBjYW4gbmV2ZXIgcnVuIGJl
Zm9yZSB0aGUgVUFGIGl0c2VsZiwgc28gMi8yCm9ubHkgbmFycm93ZWQgdGhlIHdpbmRvdy4g
UGxlYXNlIGRyb3AgaXQuCgpUaGFua3MsClNoZW4=

