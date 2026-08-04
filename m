Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B59F3B1009
	for <kvm@vger.kernel.org>; Tue,  4 Aug 2026 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785857575; cv=none; b=KNxbHoZRWk2yCMAfVtScmSmqBSK7WmJQASzkGxmlAYCBXJLmPwH+11G6aQ2c95SRgEQjKzSo7YPxXJ+n6X/NCVQWW3GGVD0GIpy+xo3P2vlEgsW73pyz/JlZLUepnengaYlC3Ysv+WUpSy8uhQm2CeniVl3/mXjEF+4eAGvN9cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785857575; c=relaxed/simple;
	bh=rthPXyk0iRCzdRdMD7r7ceKjzXMPZHFbOskRlPOR3QE=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=qrce1WszaYjT7BFCKgV05LE9+6SebamkYbnqSO18c+R3T8NFW2KzqSVRJgpBbvwduDTen55PDeY4IUkeKr+ys9itU0MGSF6AyhiljXWYatZPp7UWeqtYWSF25CGoTomgk9zX/LrNooghgvKd3w+dXJW6LHA5IdOSZHgyTcApbOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=eyEMwqvE; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="eyEMwqvE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1785857569;
	bh=rthPXyk0iRCzdRdMD7r7ceKjzXMPZHFbOskRlPOR3QE=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=eyEMwqvEy05Ij2LS7RZAmq9AE0z8XI+1OiBJPBRQrUeFTHqnM93hZxksV+q67ZEGD
	 HCoXI/kb72fR63oa5WQP2yW3OjAazsf3Fs/lIq8N41/MNjACXFEYUIOmx9urotzYPd
	 gBuZvR1td/Q/Zi5vXXuTy32Px2HeV5BqZLsNFZe8=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-XMAILINFO: M/BhhHt976mJj6yDh4z5r+91mooDvtzN6pC5rYB3CNVAMaUq53RKlsv39r07Jh
	 6yp63CbkPH6yA/chgQxtV1WM7+Plhica9yMrH72EcBpuDeCauPVDtwxnVvlrfXMihTY/Jxj8Qf0QV
	 aOETV5w9kYZEPZ0PFAsg6nWfQ+sgffAi1Z9CGEd0Syt9hDIc36RZQ/tNkjOJ8GZUbk6T51gK2LO7D
	 uXH1aiQ3X1mtQsZ1Nv51RcWa8aNT1I+R7FlDx9HxUbAKgVkw1ETUK0hv8FnIjsS3iK0R/0foURZYI
	 ovTPJrCk5ip4mWDne3ZvJE3oGL+NMYM3t8AytXZxD4PHgp+g6zWGwt4aAschLeBlLEdwlnyUXgPAv
	 f9RCJWceSgQWZO9XrfmKnRbzM/MaAD8QH+iq7jb7C9SsdXJPIk8r20+Rf0VxR5BQ1BnVn1sbqk+yx
	 tLQLqRjIL4ks7pMOOaqhaA9KMy12qFbiB37kzYYRrpz7AeKTPM2iFkAzVmaw4KA3IrFwfaU5xfHG3
	 5ua0awIp6HhzxYFUNWTRHxiG3KeHs3SvJZSozxlEQ0l0gR+4D3q0UsV/lJUiiBV0D5k48Xilsz3qz
	 qI6Q0gywi3UEg4u+wwq+vCZHnGlUR0o6GP7zKN79YiXcL6Ve2Rvfp0i6USiQ7Rke7QwuVSJSZzOsY
	 GfhR45OnRA+BJc48nnQzUfOeEpddJc4q8RIL3kJD4X3zyQD9cgRlOOBuKE1bSDMFd1fo0z5E2HEf8
	 9OGIVL/ABNVZ5LwCuJzcTzEY/05yzbJ/bxB3dLzbhGgjQjDllg2S4aWYWhB4/qfBomZBgy8mnCwoC
	 coEx7IdxxlCjIz+d0SFf8pEzGKmCNFRVNVXhwFEjZUPsI912jx2UALoMqmcasmIVoZw/fNh6JuBWc
	 ALncWfPAgC0+5iSGejRoU0wp4h4/c9eEGazPdUsodDjgjSXNLf+QvH9wHW7Btt308klR9h49q5Q0/
	 9wtKmEPn4IUlkVWoBjcgtSl6u5EfBl2fXHTbBv+9NOkhrJr64vcy339hEeM/m1Q9fJXaZZg+Ttj/M
	 9AcC0AGKNU0fQOX7SS3mpPEU/fKHcGauiJ5/qUzDjk8bAXGyf33+FMZZJCrAVBGYCkgMPjYRGNG0c
	 DYlRC2jqCirp2Huo/64onrFy
From: "=?utf-8?B?U2hlbiBZb25nY2hhbw==?=" <grayhat@foxmail.com>
To: "=?utf-8?B?VG9tIExlbmRhY2t5?=" <thomas.lendacky@amd.com>, "=?utf-8?B?a3Zt?=" <kvm@vger.kernel.org>
Cc: "=?utf-8?B?UGFvbG8gQm9uemluaQ==?=" <pbonzini@redhat.com>, "=?utf-8?B?U2VhbiBDaHJpc3RvcGhlcnNvbg==?=" <seanjc@google.com>, "=?utf-8?B?QXNoaXNoIEthbHJh?=" <ashish.kalra@amd.com>, "=?utf-8?B?cGdvbmRh?=" <pgonda@google.com>
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
Date: Tue, 4 Aug 2026 23:32:46 +0800
X-Priority: 3
Message-ID: <tencent_CA128C6270F0E6592EA91DC804E9AA40E50A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_625C0F42824E542C72B34733392AF2C49709@qq.com>
	<e853c904-cfee-491f-85a0-162e1a3997d5@amd.com>
In-Reply-To: <e853c904-cfee-491f-85a0-162e1a3997d5@amd.com>
X-QQ-mid: xmsezc57-0t1785857566t3wynnxce

T24gOC80LzI2IDEwOjEzLCBUb20gTGVuZGFja3kgd3JvdGU6Cgo+IEZvciBmdXR1cmUgcmVm
ZXJlbmNlLCB5b3Ugc2hvdWxkIHJ1biB5b3VyIHBhdGNoIHRocm91Z2gKPiBzY3JpcHRzL2dl
dF9tYWludGFpbmVyLnBsIHNvIHRoYXQgeW91IGluY2x1ZGUgdGhlIHByb3BlciBwZW9wbGUv
bGlzdHMgd2hlbgo+IHNlbmRpbmcgdGhlIHBhdGNoLCBlc3BlY2lhbGx5IHRoZSBvcmlnaW5h
dG9yIG9mIHRoZSBwYXRjaCBiZWluZyBmaXhlZC4KCkFoLCBnb29kIHBvaW50IC0gbXkgdHJl
ZSBoYWQgbm8gZ2l0IGhpc3RvcnksIHNvIGdldF9tYWludGFpbmVyLnBsCmNvdWxkbid0IHBv
aW50IG1lIGF0IFBldGVyLiAgV2lsbCBrZWVwIGl0IGluIG1pbmQuCgpbK0NjIFBldGVyIEdv
bmRhXQoKUGV0ZXIsIHRoaXMgb25lIGFuZCBpdHMgY29tcGFuaW9uICgyLzIsIHNldl92bV9k
ZXN0cm95KSBmaXggcmFjZXMgaW4KdGhlIG1pcnJvciBsaXN0IGNvZGUgZnJvbSB5b3VyIGIy
MTI1NTEzZGZjMC4KClNoZW4gWW9uZ2NoYW8=

