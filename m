Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD821F03DE
	for <kvm@vger.kernel.org>; Sun, 26 Jul 2026 17:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785085678; cv=pass; b=V8DvztltvyN1PMMzkDTKbmtSvoVxLxYgs0ghuVZ39dPu3UMQRwT17iEQjHxiWcjjeKz63rQOQjJckXZEg6UhgUMkodYwJ2+BaPZRdgC0hyR9NVegR6LUtmxzt1TdMXieDEMvjgDz87sQZ6oyhW27AvW/mJ01Fw2mt/HJTUxVYlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785085678; c=relaxed/simple;
	bh=cPg5ccRJxRM6k4z6IzevaqPF6Ah1XrL9kh49demBofw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GzMouDfbGPt+AjV4o7p9kqmFjXKH0gjP7Erx4d9+5oY1/o05ry7VHJFSy6pOC34JQIVhDk23eX9qY720vieqzvYMbCmReDGabJFm+ZtH/RcNtDvsg4cdGJ8o+PbzIa2P6q8G51/Va/K1zOJI6E6kMUW0K3JiIRz0JM/ggF+un/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ULoqpL/K; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVuG6aoQ; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULoqpL/K";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVuG6aoQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785085674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsRswBDBs94IKch9v8/EEqSnL/yDX47FS1oaPfr9Ziw=;
	b=ULoqpL/KO5ZF6066JI8ZDBoixZDDS/8QOOuuJB9mX0pIO99U9chAEUUfWrqMdA+RQ6cwem
	0PnbGfTylVNCsuangyF6kznJvxhtO83JGdJgV94riw1xPuAl1gm0+bbEymCGFMBYzzluE1
	/9h8XRNyfypIHtuznYb7cgzqVjobd8A=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-jCltlMwFOXOzErgi5lsRUQ-1; Sun, 26 Jul 2026 13:07:53 -0400
X-MC-Unique: jCltlMwFOXOzErgi5lsRUQ-1
X-Mimecast-MFC-AGG-ID: jCltlMwFOXOzErgi5lsRUQ_1785085672
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8484b9fb055so4594213b3a.0
        for <kvm@vger.kernel.org>; Sun, 26 Jul 2026 10:07:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785085672; cv=none;
        d=google.com; s=arc-20260327;
        b=eBO+W0xBxDQlCSnWWncTPDRHoHn0lCFbQmNUJDILN7fxB0iebpJ18NJdqr6OxtPD1m
         xqke4hAFFQf1mxQlz3SViso1UbJIr4DRQEXMH53vbA2uIq0TS3LiREEl+iNe7P1yGVCO
         4m2F3OLniFo50rLJ5Wc60iS7bYDzG8JHmt0uxIqbI4OhHKvakVcRvO4K+CDEJnw1eDjW
         A9htY8rGxrog8akruvMr5keUrAB/8xu+klcfQwYdesJ3P1ouyRhCHpaVA+j0I39XS9Dy
         9loNqHE2quXzgGJwxYqirD7f6CvVKLRDIZBqppENZWC6rm6UTU2FnBFKzZxeCHwvYQIz
         kb2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lsRswBDBs94IKch9v8/EEqSnL/yDX47FS1oaPfr9Ziw=;
        fh=yLt7Ffp5j60zaqOl/UERGNA7lGRn2kbGSKCHlnElFcI=;
        b=NbGQIh8dh+C3oR7pAAfu0aWleBn7j9p5M3rOV+aWwnU2aKkvUbiVyDB1dpcV53fjdH
         tNUQZ0WgueoX0xXyMvweRX32XK/7M3JG3323LDTMH67QnmJjq6K4UgBhqPoT9YUV3Gum
         9EYS53NHmynZS4pdC2oyR4ij88LFZ4tlRWjBUiyWGUYEByM7fsbYWPCb9zrldJgLO6+4
         q1qD+pyWgLiNO91+3/TcMbAmmzuwF1DcbWYetOpEyN4EY61cVfcu5wwe4sTHr0eGZFgi
         g2Y7DqgD+nPg75DwJGbkKnomDEZhN/nrHLHHIYf6Qn6yv5L/sij6oQFN99K5qIbzdhkF
         pL1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785085672; x=1785690472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lsRswBDBs94IKch9v8/EEqSnL/yDX47FS1oaPfr9Ziw=;
        b=aVuG6aoQrZzN3dq+izBVmmtpygTTJ5hiqZxk/+J7g5K9t/8uICo3dmCiai4tCpjNHr
         vZgl0erA9tKu4lqbS8GKbPNk5qHMtab+uCHSvEradAqt7r5Ht6NLMGR9KvnwjJALwagE
         Oz6R9Tc8wf2YdcUu7DLoMX8L0y+Ns49N/FI2EVpPWhx0ZGoahH8JaJT4JAl+O2+GHimB
         FA93ybO6Ryy1j0PCOCZLdAZ1y7BlWVUKQekZKykDOa56uW76W2gJX8isSJGxuqhYvnPB
         u3YFShJxLKUsKR+cu66KpTNJiYMgAH8wVhCQgQQGgNVTw8sYLOC+MPvOepX+qYd0UXEo
         QSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785085672; x=1785690472;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lsRswBDBs94IKch9v8/EEqSnL/yDX47FS1oaPfr9Ziw=;
        b=lgmo0/XigZ7uIJVWyKXe0tVPwQiW91I75eCQ7C8lU0oQfAkPHxNkT1LRKolLEllEa3
         raxFQSoaNwe02W7DyVXKUrNxJjIBfl3tt9VApFxHPMEFsxS6qTT6WEl6OgiLih2+v6md
         7nZUiowG9EaeuOZ0g+A2vAMAt2Lk6og62TNQVF9xbksetFVOFB4WAoYXYKsRc1QcqvVF
         BFUZpQxme8lH3UdSBCoN40lsvNt30EUzsC9DdAsE/csbXyCG/bdVmtm4CxVH65AXVq1t
         ahDC/9JESgmFDgUWL7v/Zu+v/1JPQC1euKls3be8okjtmQllxStJKRApMbzQnQcPtEOK
         Cvtg==
X-Forwarded-Encrypted: i=1; AHgh+RrI6qrh6pBrFQWifcuHXCK+1uq4hcoIhrd8aHkxo2lm/kI24YXxBad3Z8CoI5tFI8mWMno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze08nHpytI8LPK+s6Arp33VHhaQbsVA8u9EQIhEMMMg2+cOxAd
	FizeBSU69v2A78WhvHZ8Uhik7BXV86epR8FUJ+3Hm3b269s86G2T6RLVW+CUo8XjABAlpE7Bx3Z
	RIWjLQx2sKKB4t+KiVaca68iqFBcHFDdbdrLUW4cb/ouHTbEuQWCj/vf0vv6O5K3K6DD+o8+V7s
	A/x49gOQRsEuyZrlVbKql+EFagxmuQ
X-Gm-Gg: AR+sD13i/wNaGuvAtkqEHVE1LzbVxVa8qv4tb59HYOW/5bo+oDjV/myNj4JQyjDVZNv
	OLyyo+Dv4+VNW7P39kf8nfpl3OqzYptyHJapen80cdGKEdyfjJKtBHBZJLZroG3VnpcW0lPOeVK
	gSdTnq2adXjGUa4tGBvdXfSCi0S6L/ik0w48XX8xMW1TKDZqR3w9GHvEmLXcV2tXh7an7BtTQ4W
	GVm5i34mNi35GEekm0FBa3ZzvO9U3POdDiVEcppHo+jciPutUjbT9U9VWbSvgSdHpH5aDpRmaX2
	hw==
X-Received: by 2002:a05:6a00:1941:b0:845:4d71:8d15 with SMTP id d2e1a72fcca58-84e59568c44mr4570116b3a.37.1785085672351;
        Sun, 26 Jul 2026 10:07:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:1941:b0:845:4d71:8d15 with SMTP id
 d2e1a72fcca58-84e59568c44mr4570108b3a.37.1785085671969; Sun, 26 Jul 2026
 10:07:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com> <20260706-fix-v1-2-4b83a70e9f3b@redhat.com>
 <f83491f5-6ef7-45ba-bb84-26341835cb25@tls.msk.ru>
In-Reply-To: <f83491f5-6ef7-45ba-bb84-26341835cb25@tls.msk.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Sun, 26 Jul 2026 21:07:40 +0400
X-Gm-Features: AUfX_mwazrnzMndJzCGb-2mtrqBKCeO5yvvmYB6OW837EQqmgIK99psDDoK7xAA
Message-ID: <CAMxuvaxUWc=Qr9pQQ6wW6XnAzp4mf77aYpcFuXvret1KL_W9kA@mail.gmail.com>
Subject: Re: [PATCH 2/5] ui/vnc: fix OOB write in vnc_refresh_lossy_rect
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
	=?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Sun, Jul 26, 2026 at 8:54=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 7/6/26 15:53, Marc-Andr=C3=A9 Lureau wrote:
> > vnc_refresh_lossy_rect() always marks a full VNC_STAT_RECT (64) rows
> > as dirty when refreshing a lossy tile. When the display height is not
> > a multiple of VNC_STAT_RECT (e.g. VNC_MAX_HEIGHT =3D 2160), the bottom
> > tile is partial -- the last tile at y=3D2112 has only 48 valid rows.
> > The unclamped loop writes to vs->dirty[2160..2175], past the end of
> > the VNC_MAX_HEIGHT-sized array.
> >
> > Clamp the row count to the actual surface height so partial bottom
> > tiles only mark valid dirty bitmap entries.
> >
> > Fixes: CVE-2026-48002
> > Fixes: 7d964c9d2fc6 ("vnc: refresh lossy rect after a given timeout")
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3950
> > Reported-by: huntr bubble
> > Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
>
> This patch has already been merged to the qemu master branch
> (as commit 3543c2b855c), but it seems it's important to mention
> still.
>
> There already was a fix for CVE-2026-48002 earlier:
>
> commit 46ee49034d26d04d95ba8f3183d4fbfa9d2b89b4
> Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Date:   Thu May 21 11:33:52 2026 +0100
>
>      ui/vnc: fix OOB write in lossy rect worker code
>
> which touched the same code.  Now this one, with a
> very similar subject.
>
> Unfortunately this (additional) fix does not mention the
> previous fix, so there's some confusion about which commit
> actually fixed this issue.  It looks like the first fix was
> incomplete and this additional fix were needed.

That's correct, we reused the same CVE

Daniel P. Berrang=C3=A9 said on the issue:
We didn't release master yet. As long as we also didn't release any
stable branches that claimed to fix it, we could re-use it IMHO.

