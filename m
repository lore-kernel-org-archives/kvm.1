Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D68641C30E;
	Wed,  1 Apr 2026 11:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044322; cv=none; b=OhI1rTZZtN7IdktyePBlLkiufkeCsDWCaNxHzNfg5fTIaZkpnYkZtUNeYBr9/fFFbceasinuTmnNHA7iyjjfMVoNeG+kvLNEcSwMWy2yYugAVRKwNmUTmf/uGGArS76+Ih9t6XRQXDfv96TI+JipzpectihQelueYAxabB3zqPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044322; c=relaxed/simple;
	bh=7L4WkfPh6nO2S1TvOry4899M1DbJn9sacbEffsNVaYI=;
	h=Date:From:To:Subject:Content-Type:MIME-Version:Message-ID; b=Elr0rK/PvIFb4onQoPKzNYbFCKdf4JnQM6GaBpO5PE7c2o+UU6o0UUCnrTGlr11o4vW0b0QgtSaYEG5VkSixn4Jtplgtn3tawk1qYM34gGZkrL0UBOuS0JjwvLoHySv8qOK/s1Q1Sjz1hzQ0dBDxBXg7uc6/klzsP+uyMopqW4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=J/39i8Yh; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="J/39i8Yh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=7L4WkfPh6nO2S1TvOry4899M1DbJn9sacbEffsNVaYI=; b=J
	/39i8YhEdYJ4UlfafAyqqRqMPXLitjalm0K93hHc6f2b9c+/MWV+1r4/S1pU4rne
	Qojut7MumvbQLeJahi1N4RiB/0IbOSZDpCK+1FRVk50kGD/DUkmHTcyzYVuNTzss
	NT9Fk6Hvzg4RpCw9RUTRBg+t1PQSHQisZK6qpQHL2s=
Received: from pcj3195161583$163.com ( [87.83.109.74] ) by
 ajax-webmail-wmsvr-40-111 (Coremail) ; Wed, 1 Apr 2026 19:51:30 +0800 (CST)
Date: Wed, 1 Apr 2026 19:51:30 +0800 (CST)
From: =?GBK?B?xeGzvb7ZIA==?= <pcj3195161583@163.com>
To: seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiaoyao.li@intel.com
Subject: TDX/non-ACT: failed TDH.PHYMEM.PAGE.WBINVD after successful page
 remove can leave a page unreset
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 163com
X-NTES-SC: AL_Qu2cB/yfu0oi5iefZOkfkkoRheg8WsexvP0v24dXc/kEuBzgxDs7QkNIJFfH79uIDSS2qQCdaiVx9eNmQYVaBweGu92Nq8CaGpAMJCidMQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5a73e445.aca5.19d48e268dd.Coremail.pcj3195161583@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:bygvCgDXX_TDBs1pR7GFAA--.6230W
X-CM-SenderInfo: 5sfmjiqzvrliqvytqiywtou0bp/xtbC8QN-RmnNBsOzOgAA3j
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CiAgT24gbm9uLUFDVCBwbGF0Zm9ybXMsIFRESC5NRU0uUEFHRS5SRU1PVkUgZG9lcyBub3QgZmx1
c2ggY2FjaGVsaW5lcyBvciBpbml0aWFsaXplIHRoZSByZW1vdmVkIHBhZ2UuIEtWTSBoYW5kbGVz
IHRoYXQgYnkgY2FsbGluZyBUREguUEhZTUVNLlBBR0UuV0JJTlZEIAphZnRlciBhIHByaXZhdGUg
cGFnZSBpcyByZW1vdmVkLgogIFRoZSBwcm9ibGVtIGlzIHRoZSBmYWlsdXJlIHBhdGggYWZ0ZXIg
YSBzdWNjZXNzZnVsIHJlbW92ZToKICAgICAgIEtWTSBkcm9wcyBhIHByaXZhdGUgcGFnZS4KICAg
ICAgIFRESC5NRU0uUEFHRS5SRU1PVkUgc3VjY2VlZHMsIHNvIHRoZSBwYWdlIGlzIG5vIGxvbmdl
ciBhc3NpZ25lZCB0byB0aGUgVEQuCiAgICAgICAgS1ZNIHRoZW4gY2FsbHMgVERILlBIWU1FTS5Q
QUdFLldCSU5WRC4KICAgICAgICBJZiBUREguUEhZTUVNLlBBR0UuV0JJTlZEIGZhaWxzLCBLVk0g
bWFya3MgdGhlIFZNL1REIGRlYWQgYW5kIHRlYXJkb3duIGZvbGxvd3MuCiAgQXQgdGhhdCBwb2lu
dCwgVERILlBIWU1FTS5QQUdFLlJFQ0xBSU0gd2lsbCBub3QgcHJvY2VzcyB0aGUgcGFnZSB0aGF0
IGhpdCB0aGUgV0JJTlZEIGZhaWx1cmUsIGJlY2F1c2UgdGhhdCBwYWdlIGhhcyBhbHJlYWR5IGJl
ZW4gcmVtb3ZlZCBmcm9tIHRoZSBURC4gTm9ybWFsbHkgVERILlBIWU1FTS5QQUdFLlJFQ0xBSU0g
Y2xlYXJzL3JlaW5pdGlhbGl6ZXMgVEQgcGFnZXMgZHVyaW5nIHRlYXJkb3duLCBidXQgdGhpcyBw
YWdlIGlzIG5vIGxvbmdlciBpbiB0aGF0IHNldC4gVGhpcyBzZWVtcyB0byBjcmVhdGUgYSBzdGF0
ZSBob2xlOiB0aGUgcGFnZSBoYXMgYmVlbiAKcmVtb3ZlZCBmcm9tIHRoZSBURCwgYnV0IGl0IG1h
eSBuZXZlciBiZSBmdWxseSByZXNldC9jbGVhcmVkIGZvciBzYWZlIGhvc3QgcmV1c2UgaWYgdGhl
IFdCSU5WRCBzdGVwIGZhaWxlZC4gRGVwZW5kaW5nIG9uIGxhdGVyIGhvc3Qtc2lkZSBoYW5kbGlu
ZywgdGhpcyBjYW4gYmVjb21lIAplaXRoZXIgYSBsZWFrZWQgcGFnZSBvciBhbiB1bnNhZmUgcGFn
ZSByZXVzZSBpc3N1ZS4KCg==
