Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046D947B435
	for <kvm@vger.kernel.org>; Thu,  6 Aug 2026 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027269; cv=none; b=flwc7GSrqTeWXu9eaPPSO3T1MMEAfkY41vlDCpPW3cx/mvHFeY+0ffQmw5VUfemg2gXUbLWq3N3tuMoa7JSzNxcVKMxMegXsifZ6um3gJBHUK4kgYbctexq1eSfGdDSmEJqqj3XNorzLtybdBnDp7ng5eWL32UYzTcUESMvAzCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027269; c=relaxed/simple;
	bh=6cmFYVMu73th1aHOSMprwyarfaUnwy0dEjQi1Mzyj8Q=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=Rvo6cSmpl13Ht64xMMk2VF8reAL1WNVlY2KgX55DvszCFpchnABIk/ZyASHdeeeH3TqQvX2iWcYY5pSHrp2N9P+KDeV9Ll+1MRf3muJ/78qg7IK6MYCLs2Qu/T+RP9KX3ZOfFfb76hBUXLUOrxAoOK2aC/G/An0fgXZKSspE1Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=PV5CTulM; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="PV5CTulM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1786027253;
	bh=6cmFYVMu73th1aHOSMprwyarfaUnwy0dEjQi1Mzyj8Q=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=PV5CTulMahZh5DHGkSJNuIuSDLeF8r6AC7AWv4VT2QTgg0xCaN3vQhwl0fEI8qiur
	 AtCwtJYXM/g1iv+ZKwodWDKT3AxiliSxxkt8rg5LX/HS5thJuBgpYEIgfH9rhf3nIO
	 IbZJ8H58SXxdDlBFhJPJ4Meh+FU36AT4KEurBWjY=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-XMAILINFO: NXWOa7S4FArGzQxfq4ihwpDnQOA0EfIh2JNyn7fvQ5L7HzIzhVORmwip5q0jLZ
	 43bcKLnIHlqsher6+UUl5gz6RNzdA4A1cj/KuA3mTOTvX2BfPNuH8M7PJ1LlKl+SEIeEdhCFnPvWa
	 yvoCfhSVbs07Kk99FtjADfcYE9Z4ouZIL+/b1xS2Czb8g35La3EUrvqXleMJfcwk5MwUQA9N3DMlG
	 CjBjQnR6lzkwKPAaMiuJuwWCR6Ai8p/uRRGxmCzDFDs3sNxpCsCc1MiLYZrJySfrOyF3AZogr33Pt
	 TFIjEMoU6r0kMVrOqSR6QpgVsF+3gevkVQvJMTjVrweheYlQ+N1W5mUu5xDv48170Riqjt5WTpARH
	 eVsySk3LTB2oye0tfDnjgZTKShnaw4rFe+nQPHBVpLJA88RhfgaBxphMvvqLjz05XgnXybzLeL6qF
	 Af77NooRULg/M0m4O7N63cyJTHIIJp5HIdF+GC778Ji2/InHMuSZe6DTTr9BM5QnqT1XFyhqEr+yP
	 T8bhoYzIrpxeRDs+UAlX2uB53d0OtyGpHeI/z/Twl/BIsUZzgLdaI224WpHXp14gdNgzgbfg7b3hm
	 Qx3NPt6sS9vm+nwzHuCai9jvhbvklzAyCukQXPr/EB4tltd1OlcpPNAr1+n/nddpBgL5TZ2S6De3k
	 KBY+NequtwfyBKPe87QP65IBz3cxNRhfZN73oMVHIwogPK87unlQLsCXJETffbUFva5/EVV+lf0Rb
	 palZGt9WKo/zqce9mOgotnJiwEBpIPu5DGcRb/jUzUB3pQ0tDGjE5+5B/sNlTzKRRNzuuyRRBdKrv
	 MB3ziwAdthWwr33jT7lqRuNEo42Jx00GK84+DvSZtRXARlG82eIbVniZbYbv7LjovizZTm916+enP
	 PhbhC6iizkvzH4rhcHawDgXLUPUXngEGI4QOxO1onoya60hZX0691/Py1jb5J6s5Xfxw/tYp8S4ok
	 jAraqU9UmjXMsW+r57Ei/mkYPINwV1ANHQ/pBffmssSiY8nBliFqF5l+AmFYCT2/z1B7maEJ6EP79
	 Sfp8hyOWqx1FkRA5UMZWExm0S8cjRLtD7+GfvdVb+hosvp5U/uAXdtQs0NrZur4Y+Sh2L
From: "=?utf-8?B?U2hlbiBZb25nY2hhbw==?=" <grayhat@foxmail.com>
To: "=?utf-8?B?UGFvbG8gQm9uemluaQ==?=" <pbonzini@redhat.com>, "=?utf-8?B?a3Zt?=" <kvm@vger.kernel.org>
Cc: "=?utf-8?B?U2VhbiBDaHJpc3RvcGhlcnNvbg==?=" <seanjc@google.com>, "=?utf-8?B?VG9tIExlbmRhY2t5?=" <thomas.lendacky@amd.com>, "=?utf-8?B?QXNoaXNoIEthbHJh?=" <ashish.kalra@amd.com>
Subject: Re: [PATCH 1/2] KVM: SVM: Serialize the owner's mirror list in sev_migrate_from()
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Thu, 6 Aug 2026 22:40:51 +0800
X-Priority: 3
Message-ID: <tencent_66858A4D2EF0A83787469EFD12EAC16BD006@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_625C0F42824E542C72B34733392AF2C49709@qq.com>
	<0e9c3989-c7cb-493c-8fa7-4005e1d772f5@redhat.com>
In-Reply-To: <0e9c3989-c7cb-493c-8fa7-4005e1d772f5@redhat.com>
X-QQ-mid: xmsezc57-0t1786027251t9fdeann5

T24gOC82LzI2IDE2OjIwLCBQYW9sbyBCb256aW5pIHdyb3RlOgo+IGFuZCBhcHBsaWVkIHRo
ZSBwYXRjaCwgdGhhbmtzLgoKVGhhbmtzLCBQYW9sbyDigJQgc3ViY2xhc3MgMiBpcyBpbmRl
ZWQgbmVlZGVkIHNpbmNlIHNldl9sb2NrX3R3b192bXMoKQphbHJlYWR5IHRha2VzIFNJTkdM
RV9ERVBUSF9ORVNUSU5HLiBUaGUgcmV3b3JkZWQgY29tbWVudCBsb29rcyBnb29kLgoKU2hl
bg==

