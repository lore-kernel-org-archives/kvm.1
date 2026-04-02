Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B9F2EC0A2
	for <kvm@vger.kernel.org>; Thu,  2 Apr 2026 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775158456; cv=none; b=B2ly67HNZChSIgTmf18LL/TIfU3Iix7uJq9g1perzb2nsR3rqHsJQK0rSBJqEYZhmypCqjGlmSQvo8f33GZHVqxyQ3HIKrf75P8SZz5HPPduYn9RWmVUQ2FvauUYxj9NY56vRSInp8p1n4/YHqfnUOBCgIDUJFf2IT/9gL5TVRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775158456; c=relaxed/simple;
	bh=77owBfcfXAbQ+XL33KQYqnXu2wee13wnLptzfU6MBIM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FdrpzW84tgApnvopZizbarjRJMEG7HvEWFswyX4uGyWDCe1g79RYjWaVD+Y4fhKvJ2Aucdls307AhCy2EKstP+fAB3CcZtiHmn8KZDwEF4R4MNtbrRIcjj+27TgRqFzQ96u52nsrFOI/NlGTsB6mxrw5qfid2qoch6VsxY7Myew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lmERNNW6; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lmERNNW6"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-c70dd30025fso1734055a12.2
        for <kvm@vger.kernel.org>; Thu, 02 Apr 2026 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775158455; x=1775763255; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=77owBfcfXAbQ+XL33KQYqnXu2wee13wnLptzfU6MBIM=;
        b=lmERNNW6RL4m8dVcZz8zxnNtpeHTOvDXlZ0PmUBIpNjbn2Eeh9Rin2N+7agbKyMBfx
         aAoK9CJShzk6TdKnV93ullpPhssr0XBcK4JLXpA/BnrqCuhgGFd/VvhIH4616cBoMz1A
         cj9lw0SbLNDzVvmhiY+bYeiGu33BEshPwKA6NA6xZr/2kAcLS78ddBGtFdde+jPHcL5v
         C1GFwOv1f8wLOCLhfOgJwQvNvGGrJ5CWfElc1bAq24GSudpqfCNeMHMUt48lnx/AMdTW
         qAdM685UF39eEK5CMKrmXZQgmjvUvd5AeKq2NolDPLb35XalDm6L6a3t2DErQr/DpuFf
         woXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775158455; x=1775763255;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77owBfcfXAbQ+XL33KQYqnXu2wee13wnLptzfU6MBIM=;
        b=qxTBblQxafd+UCxLz3ABcaWOKwfyvYXOLqmvk15eS6z51Vd7FnqtwwtmWu/FvEKj6I
         AftJ+SZgkLHFhkNcTojrCj2tHuUHKqnOFLO1O2FweoijpsN/oZH8VqfPXi7wXQ8RnQq1
         NIw0NfJDsyKmmihImg9nPiE/gcjuIX9fPG+eN+yNcDMe5P0fqkN9eRpDI0+Bjw2WPwKE
         dhImc6ojEqkUBU04MBqhJgo5ChrsJZS6gUJFDOkzHSS+qZqgrJNfs+Ctl/W6gGto4vUv
         Oti0o8PJFGeCKX6OgQYuaK8Ev6cwp852NG8qpS5Nj1WhfrioiSc/Mkt4IskNiYKmbYjY
         6M+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpBq2NNWh2N0Brlra2x0fvFypWqLwG9DLknAUucH2lhCJw/RsWuctk9HSOwmS5BfUxiTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwouB1hVvJ2wIZu8H93F0kGVwh3OBedxCYuaUXOejBXS3uAZUbg
	Fam/Z7HuvIhJJirvEIauE8f6/XbvKbEiQ5jMe0qxWIRo3SVaT2C6nIKNgp5rYfoXAW44/QA9TKY
	Tv/BKKw==
X-Received: from pfqp30.prod.google.com ([2002:aa7:9e9e:0:b0:82c:6bc2:5e78])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:72a9:b0:39f:a42:9251
 with SMTP id adf61e73a8af0-39f2ee71340mr159232637.22.1775158454816; Thu, 02
 Apr 2026 12:34:14 -0700 (PDT)
Date: Thu, 2 Apr 2026 12:34:13 -0700
In-Reply-To: <20260402051940.1051-1-spujari79@gmail.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260402051940.1051-1-spujari79@gmail.com>
Message-ID: <ac7EtdCz0GNkY6dJ@google.com>
Subject: Re: [PATCH] KVM TDP MMU FIXES- Replaced unsafe panic calls with
 proper error handling
From: Sean Christopherson <seanjc@google.com>
To: BraveProgrammer <spujari79@gmail.com>
Cc: pbonzini@redhat.com, yan.y.zhao@intel.com, kai.huang@intel.com, 
	binbin.wu@linux.intel.com, vipinsh@google.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 02, 2026, BraveProgrammer wrote:
> Unsafe Panic Calls Converted to BUG() AND BUG_ON()
> AND
> Added Proper error handling: Using WARN_ON_ONCE(), pr_err()

This isn't "proper error handling", it's sweeping potentiall catastrophic bugs
under the rug.

> Signed-off-by: BraveProgrammer <spujari79@gmail.com>

Given the name and email, I assume this is trolling or AI slop, but just to be
clear:

NAK.
