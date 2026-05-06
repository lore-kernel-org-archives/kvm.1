Received: from mail-pl1-f206.google.com (mail-pl1-f206.google.com [209.85.214.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A859232C8B
	for <kvm@vger.kernel.org>; Wed,  6 May 2026 04:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778043014; cv=none; b=R2TyoVZdjtku1vK/QUn5qRxiP0f96O7SU11Drv1nTwiOjSMUCDE29J6Xm0KpdoEsrtoG464x/pu4rinUnn+jB0fTJAQwb045vjheQ8UPnlqvVdvBW4mTWIFvVwR/eBHHpWUSMbGL/z+p3D4iEJw6+XBrv52jV4p7MAEWXDICdz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778043014; c=relaxed/simple;
	bh=upi/0MrFS+m40QoCnmF+F39BUbtph/eDC/YCpspDdXY=;
	h=MIME-Version:Message-ID:Date:Subject:From:To:Content-Type; b=HbsmrWHgj+WGuvNYaJFoiE3LCC2ch53EmnT4yhURknJWjdK1LgyyQfLvUDpL21ZQicKMFSJqMois/6VWvgbaDsDki+Rpv2o3UalBpzhKCNaqyvcZSvsafGKY3JlCjMwQ5X3J8HyeRYCKttrehySqsFlNet4PNv13Lgk7YDTFHg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=maestro.bounces.google.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8AK9qQv; arc=none smtp.client-ip=209.85.214.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maestro.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8AK9qQv"
Received: by mail-pl1-f206.google.com with SMTP id d9443c01a7336-2b4678c6171so54514335ad.1
        for <kvm@vger.kernel.org>; Tue, 05 May 2026 21:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778043013; x=1778647813; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:date:message-id:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=upi/0MrFS+m40QoCnmF+F39BUbtph/eDC/YCpspDdXY=;
        b=l8AK9qQvA0rTQKRzAmf1HVfYszPhqQ9z/h1XXu47EnIb6EUU9J2o0BkbxsY6NY8Uay
         q1GhNP19NawXSiADfnOjfN5AOcO7WZp1u0YUc630UAvyA/df5Z34MvJG0OAugkflaMiK
         bXUBe+BqkgB9j8iXyWVGpd/fvX8tDYGtO0jBrEveJCEtwKVRqGotkdKoYJGodwMPjxpq
         DwyQrJ95tB562ZGf0u18hrQpZw6SxtkHoFrDuSVpx9KAZwNz5sBWVrMeyrk4zz8PgnlM
         hQsKo8BLH8pZxUgppWMjGX8Bok0+0hIWHJxqfZIq6ZsSDQd0nKdGzSb/jAdzYY92YEB3
         9ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778043013; x=1778647813;
        h=content-transfer-encoding:to:from:subject:date:message-id:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upi/0MrFS+m40QoCnmF+F39BUbtph/eDC/YCpspDdXY=;
        b=F7VmDLqJHCWYJsevyS80a9o4BtLy6cw97ijLpwJ0RcxhLLDJmgVezNWyGm9+zmcdhL
         T8ayTzDy3DkgrFMMEmcsBrrWNcRrPTFdxSlUubkunhiBqZECTQgsTn8k/rMgHrdt+EYK
         6y+WAdGnTP2g8yZZxcQqD3tD/malH/++QaYFrGatLjj8HaV3eZR6u7U3guvKzhieEQa3
         5HalFV/atT0rjI1+XHCOiJrKZ4YaW0f9QjQoCmn3ACKEHHER4tyReDX++6FoZopMxmXL
         0VYgEuvssTFjFk4ZJtzqsax0SEicBF+rS0NmtOxRkG2+FVCJGeGiJ7pcDgzoHppUTdQt
         75ug==
X-Gm-Message-State: AOJu0YyGiKtYIOR1XELgxRfgjE3fjFvgonojQwFb1HR644CG/Hc0zQKi
	aR5p+1GH9LVuSPfkTvDAPsNKBpMEOw4eIBVPGb8y6thho71qOQzgugdyjK2eRrtEHinNFgTARdi
	ZaBxlrXDM
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:3c2b:b0:2b9:ea53:4cfc with SMTP id
 d9443c01a7336-2ba794b8118mr17938075ad.19.1778043012777; Tue, 05 May 2026
 21:50:12 -0700 (PDT)
Reply-To: submit@atriojournal.com
Message-ID: <autogen-java-8febc3b2-6970-449b-90d4-415656c259db@google.com>
Date: Wed, 06 May 2026 04:50:12 +0000
Subject: =?UTF-8?Q?Submit_Your_Research_to_Atrio_Journal_=E2=80=93_Scopus_=26_W?=
	=?UTF-8?Q?eb_of_Science_Indexed?=
From: Editorial Coordination Office <rabajong728@gmail.com>
To: kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

RGVhciBLdm0sDQoNCldlIGFyZSBwbGVhc2VkIHRvIGludml0ZSB5b3UgdG8gc3VibWl0IHlvdXIg
cmVzZWFyY2ggbWFudXNjcmlwdCB0byBBdHJpbyAgDQpKb3VybmFsIGZvciBib3RoIGN1cnJlbnQg
YW5kIGJhY2tkYXRlZCBwdWJsaWNhdGlvbnMuDQoNCldoeSBwdWJsaXNoIHdpdGggdXM/DQrinJQg
U2NvcHVzIEluZGV4ZWQgSm91cm5hbA0K4pyUIFdlYiBvZiBTY2llbmNlIEluZGV4ZWQgKFNDSS9T
Q0lFL0VTQ0kpDQrinJQgUmlnb3JvdXMgUGVlci1SZXZpZXcgUHJvY2Vzcw0K4pyUIERPSSBBc3Np
Z25lZCB0byBBbGwgQWNjZXB0ZWQgUGFwZXJzDQrinJQgRmFzdCAmIFRyYW5zcGFyZW50IFB1Ymxp
Y2F0aW9uIFRpbWVsaW5lDQoNClN1Ym1pc3Npb24gRW1haWw6IHN1Ym1pdEBhdHJpb2pvdXJuYWwu
Y29tDQpBdXRob3IgR3VpZGVsaW5lczogaHR0cHM6Ly9hdHJpb2pvdXJuYWwuY29tLw0KDQpJZiB5
b3UgaGF2ZSBhbnkgcXVlc3Rpb25zIG9yIG5lZWQgYXNzaXN0YW5jZSB3aXRoIHN1Ym1pc3Npb24s
IGZlZWwgZnJlZSB0byAgDQpyZXBseSB0byB0aGlzIGVtYWlsLiBXZSBhcmUgaGFwcHkgdG8gc3Vw
cG9ydCB5b3UgdGhyb3VnaG91dCB0aGUgcHJvY2Vzcy4NCg0KV2UgbG9vayBmb3J3YXJkIHRvIHlv
dXIgdmFsdWFibGUgY29udHJpYnV0aW9uLg0KDQpCZXN0IHJlZ2FyZHMsDQpBVFJJTyBFZGl0b3Jp
YWwgVGVhbQ0K
