Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EA93EC800
	for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078288; cv=none; b=USM9yQch9kgg/4sNjtc3Sv2tKeenUcPjCJGCIJxGBzaLSoFgG9sYhKyrO91SIUAsoqFiSArsT8jd75pFfb0voHuE+jntR0GsYqK/eUQV8uXncg+2+ovFBjbuUS1GKpT2HP6nCjX2hPuA7z1xdln3qIs0Qrm6EMByixbtU5+8e7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078288; c=relaxed/simple;
	bh=UVBY7I/rBszBv2OjNaycTI0+LnLLwgzt5ty2Q+F5/BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGdA68zfuC6k+Vt9DrOB0nT+FhfeGFawU9HYfZDHo/a+X+U+88yWsEgEl1XM7DihfENw9+USE/++3xs4MThSStWHNXigOeyLLbm9J6Dj4RWueGW8NDVisM2KVr4hzuNw5DayNiHJqDuZFMxtljuKX3JCTvG6SyKoTDZyumXG8sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoQWLxLp; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoQWLxLp"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so338434a91.1
        for <kvm@vger.kernel.org>; Tue, 18 Aug 2026 11:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787078286; x=1787683086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UVBY7I/rBszBv2OjNaycTI0+LnLLwgzt5ty2Q+F5/BA=;
        b=MoQWLxLpiFHzpnkURHQbRxQGBzM3LdiTxBHHj0nMJ+2VoBlwwNrzgEWjGQ9MEEL0Az
         eN9OYyRZ0XFdYbMID51Ru6fVpZ/taaJ4C/szJ+InMo7u8QofeR6kCx8qQvyTxbodMW1i
         Kal1t7SJ35CCWvD6KNGGaW19iyzHMBG/6a5terInrOzCIWEFxJTzHy/ube82kUy7WrCW
         sNN/Wrwen59QND14prylG+Gi6TVzNC3pyikshF0v+3fvMB3P29E4AjTvslp/sDgpEi7x
         K7j6b9AadH4YaSS6KRq7yC1ILcgpKDF16K4lG4fP17yVjMEUNb7mB18RKQ6L58q+suGS
         6qYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787078286; x=1787683086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UVBY7I/rBszBv2OjNaycTI0+LnLLwgzt5ty2Q+F5/BA=;
        b=nWfe4cDm2efebWP5qScSxIqkfwylMjEtLzpEGatvszfZGIWSRG4mV/yblBbIrV6RzE
         3ydFzInApGnI5+j+p4Mi1jCdJaAvpI1yVMWBCGDap/8fl2sZL2QUqUh4xQrtzj3wmMZ6
         dfeJ0O3cAwPvGCU3j6ZdVAd4L5b1y0FzTLiOdY5FvRNvtJPfvzpEtGwnNPWbAAo+aRC4
         UUKEzozsu5Rty/s7zDVymcb15JTQsM0cYZsRBdanK2oxbKk24ec9XKEZoUCzSTe7CBvI
         l4Rh8kQZs2eo+s765BS0kGobP0GneYIrQKPTbYwt/cFuznbZBuktF8qJ5M+3gyA9DEgr
         TwEw==
X-Forwarded-Encrypted: i=1; AHgh+Rq7d+zDeIH3BzwSrbZAANiCCdGxupED+bi0n3LYnxiWwp3oVLqRkDZw7/H3jl2qXndpJCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbYZJSfnZU+df70vDmrY3jZaJuM6kfm0i5R3ZumXfyWVFr3tNZ
	CBDTJQbvUIP9ejC03DU7Uzdb81Q9v+4ywivoGPNLJU1lcr/g9es9xnGi
X-Gm-Gg: AR+sD13dU5UjwsHrmyXxf8aLt8rz3ibrfJymfl47NYnxKix87J+ExtkVK6BTLv3DAbE
	BVe/UB2N/6I+VbWmQ+JcUD2qvBf9bonOfwt9mcqNhNhoeH8yie90WfWetPsHxFBiq9EW6jFf3ym
	+lbZtv0ripbOCoGEzW2Gygf0sx65nDIL1V6oPKZTSCkI6l7sgOYFsaydKk1pawp4NQ/dAsDjGsK
	djBuYZocCPgOHO81780UHcpDtFyjFiC/SfqWJOCYHbDdML/zaPb7Nw7vQDPIK5IypvwLw4qaJrX
	gj8u5aOWc53B+4mS+Lc0UpRLfd520DCc0kF4MsTTQkMQVDh/KpNvUkC8Mt6qQRGKtdyFAV67Vqn
	hkqUa5L0iPg6//FT6bTu43G75teFIlxHGkm1enoEzIRUzs8HQSUBxWxPyqu0Z2mfc8H88sPRYTu
	/cBjR4sqQFZppNDEtswE+agyRgISuYw7eAJAwx5NAWFuVBWRqbx/1pydjSSxzERXM32atmNhDo4
	nb7QVmze9k=
X-Received: by 2002:a17:90b:57c7:b0:37f:c97a:939f with SMTP id 98e67ed59e1d1-3955a724c64mr14674987a91.7.1787078286069;
        Tue, 18 Aug 2026 11:38:06 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d2de41dsm6684128a91.5.2026.08.18.11.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 11:38:05 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: netdev@vger.kernel.org,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: validate packet source for connected sockets
Date: Wed, 19 Aug 2026 03:37:47 +0900
Message-ID: <20260818183747.3382905-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <aoNLVoPQssG1V6bt@devvm29614.prn0.facebook.com>
References: <20260813121236.2328599-1-4ncienth@gmail.com> <aoNLVoPQssG1V6bt@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 17, 2026 at 10:56:38AM -0700, Bobby Eshleman wrote:
> Does this equality work for loopback, when the CID may be
> VMADDR_CID_LOCAL and/or VMADDR_CID_HOST on host or the guest CID in
> guest?

Not in all cases. I tested VMADDR_CID_HOST with no guest-to-host transport,
where it is routed over loopback but packets carry VMADDR_CID_LOCAL as their
source. The unpatched kernel transferred data in 3/3 runs, while v1 timed out
in 3/3 runs.

The v2 candidate requires the source port to match the socket's remote port
and accepts VMADDR_CID_LOCAL as the canonical source CID for loopback. It
preserved the CID_LOCAL, CID_HOST, and guest-CID loopback cases in my tests,
while the original cross-UID injection remained blocked. The selected VSOCK
selftests also passed with no KASAN report.

Stefano, to clarify the original description: the victim socket received the
exact 16 attacker-chosen bytes; the intended peer-side socket received none.
I will use your clearer description and keep the comment minimal in v2.

I also confirmed the analogous VMCI destination-only fallback. With two VMCI
contexts, an RST from a mismatched context reset another context's pending
connection in 3/3 runs. VMCI also has a notification fast path before the
workqueue handler, so I will address it separately with validation in both
paths. Hyper-V does not appear to share this packet lookup path.

I will post the virtio v2 as a separate thread.

Thanks,
Daehyeon
