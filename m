Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DF6383329;
	Tue, 12 May 2026 01:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551039; cv=none; b=puizCT8WLZPgXsiLNinol7lrlASZ2q4ZGfUX28E4C8Tz62oUc83Ed+ZfqMqdXqoON+FEot/4zhqvjRfdKrk2QEEwjhZHkQdVnUSo51hFtpXR0M92NBO4P8+8c+b6uH05WGYChkHO8kX7yMEh2dGX+8BJUf9f4PmYeE9k2yBigCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551039; c=relaxed/simple;
	bh=hH8q+kk/6fDuIClmCBGB/tnhDHuWXgv3foSMvJnMT/M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mLf3m8AoPjrf0A3r1Xc8H/TFgiqKZPyLdIVRv3ZXf47uGQaIICUbNewyvHLIsutpiePv24Zni3AP5B6b7Lyjnp6OzP6AMZiDQbTo32vVROeW65dQb2GO/lRxznA37ISwQJFqufyyLR7F5uRdsLt3fh97lru/+JhZZgEZG8zUKkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=bO8i/LCw; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="bO8i/LCw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778550876;
	bh=KsiEnrtCJSWQlZjaZuSHiHrbCjbRIa7B5vpGcWsVJHQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=bO8i/LCwQ8vhXKJcE+AwRXZuAPJsQgSI3q7Fo/jKwL0/H1GTTk72Ckqw9Bf8fIqRF
	 tbm14+0sxh410rZ6Ju2JaNqzpU5mOxQleeRR4X1XCNT262QcBZlL1be15c65Xr/chU
	 Y25d24+qGQshSN16w/vSvGm85a5j3ipE8B4rdb3M=
X-QQ-mid: esmtpgz16t1778550857tc0037d88
X-QQ-Originating-IP: Jz09QHrjMI7WcqW2jGUJaqYXFSIwCf6TlpnCaoahsmg=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 12 May 2026 09:54:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 6620034291447723813
EX-QQ-RecipientCnt: 11
From: Qiang Ma <maqianga@uniontech.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] KVM: x86: Fix Xen hypercall tracepoint argument assignment
Date: Tue, 12 May 2026 09:53:13 +0800
Message-Id: <20260512015313.1685784-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: OfSYiviZO9YdrV3nQxC66+2vYP0f/OFUOeWsKSElW4429Vi6GEygCM2n
	mgHDoV6ceAp+gUkdjbBQm8kyND/s7Dx0Emlbk2xeq3eX0rqbrpRQzTmQ9DnEmZuNsMU3SOK
	EBgaTRBU7pMTWCuzvt25e+KyhJockazWiqwWDdXhY0Alz3yMo55AVCRjlQRSiX21UC7MQSW
	Pd3zHU4vcoAUbFfLOcunKgc+EW58NsPifb9R+8nGxPRmTCMI8Bl+ddat4Lx6AWM2ydzxzTs
	1O8Zv+E06nv1DXM3l4gZCMfjp0igkMLsxGVeC6a3y52pq8h8DUXzi5KApjX2C2dSAttznlf
	iS62icwdlwpecQMrIefzbXpVaeVlQOt3gOiMhsfPkKTZdq3u1DrFX2pfNIyy1sRbNb/N7hu
	z5db2Ip7ycRYzWIXRjftqnzva1K2g3WD4hkqlXWQgXlAOdlgSKOwa0Vr6LJTbDpxaaagTg+
	3UViGU6vYyinFhWZRtwfPrm4NbUxZtO2+fxAuVFVDvb6n9qyhIzZxUiTrnG+4EtzhIVicxQ
	kqNq0HKItAxtKh+9g7XZt+9mgSYlhAjyfsDlyUQy4KAuXdpW0Qf30bJskgqmtz+BiAc5EAM
	UZ/rFj1bG0IepJcjbXzOwUubLaI14uneWv+6G0lV8czXwjAceWd7/w/GqV3AbwxymUB5JXW
	mGNzwnr5s3Suh+de5lLlI7q1EYtxNASIYET1kPppyTFNy93g/WOvvrVZAhGa+FLsEfuuPjy
	ABvXpLaKxc4LhVrtoVfNhCrf8NrktaXSn9Qw5jfUKW0ayF+hLSKKAW7+tKX2qVAcyiL2eEf
	QY2IfJ0lVJLvaT1EBc7JpUXmpppnLSW/n7GpFuCFLUtYm2YTh5T4fLEsRFdDp1pwFgBquZW
	98DY/MqH80DXLlCogIdn40nuphOun6s92ViD0qzA/dcDFclzc0Bz8Y7NaDJ9d/FUnxDKbka
	2WyqRiumHitqEls/dqZ3mkz4UHsa0ojBUcxe+RcfdLeYLwq0IK6k0vmeC6lautCEdPnT6Tl
	KcBg2GW7M/oKt2B0aE
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

TRACE_EVENT(kvm_xen_hypercall) stores a5 in __entry->a4 instead of
__entry->a5.

That overwrites the recorded a4 argument and leaves a5 unset in the
trace entry. Fix the typo so both arguments are captured correctly.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 arch/x86/kvm/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index e7fdbe9efc90..0db25bba17f6 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -154,7 +154,7 @@ TRACE_EVENT(kvm_xen_hypercall,
 		__entry->a2 = a2;
 		__entry->a3 = a3;
 		__entry->a4 = a4;
-		__entry->a4 = a5;
+		__entry->a5 = a5;
 	),
 
 	TP_printk("cpl %d nr 0x%lx a0 0x%lx a1 0x%lx a2 0x%lx a3 0x%lx a4 0x%lx a5 %lx",
-- 
2.20.1

