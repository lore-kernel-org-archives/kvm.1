Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA5D2D23A6
	for <kvm@vger.kernel.org>; Tue,  5 May 2026 05:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777959114; cv=pass; b=EELk4Q37m5vDy3ZAKqaCaUoNbpTlHALYYAL0e//181yDDp/MPZC+oyMfSegQUxIvRC7JmpyjV6xRWBPiS7Ci0W8hyuL/4bT3ZRgdIBpKAO8yeJW6NksZepOa4cJfvT0qRaiSryRYZUDTy7a8R0y3E4Dj/zMjWyHAsWCVvOd8+p8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777959114; c=relaxed/simple;
	bh=Wr8nxSD+00xOK7biLUAPpYgeLNCwoObu/Ccrn5x60yU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XGMgJ10qDML1O6Hc7exK/fOc1s5djS60oSXQbeZ9+OByLA7qMtIq/o+POOLvKIRMA3lFGyfIS0RJzvvx2daDzygWqARBNTXdWFGeelotm2cSBZQ/hHxBhpZVTvURzSX2gjjk+DKOba1tBXkC+HTyF1Sdrx1SkrNbmT2/ZMrcrA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJx7Y/YP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ETyFn7jK; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJx7Y/YP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETyFn7jK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777959111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wr8nxSD+00xOK7biLUAPpYgeLNCwoObu/Ccrn5x60yU=;
	b=MJx7Y/YPnK/PQzljzS36280qBR9ttLUKmKZEuoFr7rkeu77kj3oTdsnaS3ToQypxgqVi6y
	QZuSwy0WUEwwoDKhVP8bj431xnBrEH+NMIjgrOXDwcbig5I60od/ygrKL9v5gjWhyYe8X/
	Wnm+35shGvhNezRz4/gUywKeTIgiV2w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-4iClvVWvNq-rUpBU1zskhQ-1; Tue, 05 May 2026 01:31:50 -0400
X-MC-Unique: 4iClvVWvNq-rUpBU1zskhQ-1
X-Mimecast-MFC-AGG-ID: 4iClvVWvNq-rUpBU1zskhQ_1777959109
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-44d79da8cf7so1485204f8f.2
        for <kvm@vger.kernel.org>; Mon, 04 May 2026 22:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777959109; cv=none;
        d=google.com; s=arc-20240605;
        b=SLFAbVO4l4a4J0/MTu1RJROYK91GvtKV9Sin3EnRU/UXvsRGIwz/3C+UN+aV6Fxk7o
         ZGhri7H+DApf+IM1xdxQL03K3zhZlfC3Bp62tD6aPVLgx7huQQwCphjQGGnCRkWdnn89
         2ti9IzZ34iWK1ozCcnKye8Qf174KwlzGof6AFBpNEDPVnuU5aFDFeV2NuDgAq5jTTdNh
         Qr9DQoO0hPagQinnwEYLSyUTF6fC/EB1ep5rJtdDaVwDgQd2H4Jj344ENmP4h+YxMCZS
         80G+YmnvssGiQ8jMaz5nnuUe9iMjj2TXEegt4hxGNOIgWwAcsUsiOCagCv5eWmmkkaVV
         u38A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Wr8nxSD+00xOK7biLUAPpYgeLNCwoObu/Ccrn5x60yU=;
        fh=+caGXhoAGwwl0lnU7FSWmEk75AnDANOjKCh61Azx78g=;
        b=bhlkuxXb2kGonBHMHxaYpUkIYi7Wz/ng6p1H3XuDGValnc3masN+1+8mrqLFRT3mxL
         kgR1h6O/XCY0KDsDTsfczNXaVZfrplqrpz4YFSVH0EnMPENV7Vwtw8duWXgcC2dFlc68
         hgMT6PWwD3WzAuRL1HnYfsdacdKguffciDtcIyDOWCPnZWDWvcbKggl+yx0Gw3ICGHoc
         S6EjDxXu0z6sUSBu+19t1/KmIDmlDq8tXCRbEr2Gso94JjQcFA8tSzbFSDBdIGCA/Udc
         Tg72W44nQdYPG/CEs9gbWLCZGgw0JwU8DOUU9q0aDgf09CrmvnzPzI0LLQSQuYx2jImx
         AwRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777959109; x=1778563909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wr8nxSD+00xOK7biLUAPpYgeLNCwoObu/Ccrn5x60yU=;
        b=ETyFn7jKa7c0ZF3yYYg0EHALLxSKF4F2+aHYhJfIRUsITauX5SJl1JgJ7BXhjxxrcA
         7cyBEGhLxZrWSJf3jUZ5Ej2Xg+NRbpPzVyvXqdYYTvrCMaC2Wt7UJlqjh6jFqN42icg0
         xWrGX9HTc79VjyTEjks5BKMCPN/YjgoPQV7weuUEJOZBet0/BXhsAqYGCoZwBtGtz7ZP
         KJ62pB/Oz1NoQh4pNx1MOvR0Ol78h3DraV7BC55+ZuS6Qxb2ymCgV0tSKfmJ7vg4HDTt
         G0kw0hckzVzsf4vrypcNb5UTGUd5s99xzbQcoP8rgUOjVFyFV5H8rumeHc3tNVHzqS+F
         Ja/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777959109; x=1778563909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wr8nxSD+00xOK7biLUAPpYgeLNCwoObu/Ccrn5x60yU=;
        b=gtlLiTui0+Bp05EdkpkIZDs0NJQrltamRVOykIUBfY+I7sZpsmmao6IK1y5nw/9l0U
         zaI5BG+p9tKGrYYLyV0em1F0bXDha3w99iomT5InsCgMfVaLnKQ5LL/KYG28IPuMpodk
         Hun5kqFrF0MDiVGvuCY8CLA4/2hzjMoC6pDjIELz813NmzlDyG7cjgxFqxGbvOF50Y5P
         8mZVzILbS5y94B9Ta/l3HtfjFqvORrDP2znE8BwR9rOAOQYGDiUm/V+j4MYQ/1C5yKEI
         ueVeHD1lnRXUctiRb4BQPSdw/XI/4xZY7Fznxf92TxG1YYygXVsnGjRqI8Pp79UPQjfI
         mlFw==
X-Forwarded-Encrypted: i=1; AFNElJ9sjh+5j8F6opNs5ynO1SchL5RzFMIw2QMEPvxvMB075ie/yqSYeuRk7dU1+/apkW3nzXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMaWTxOOd7t2pS5oInCMtPVnnuCBXeJHcti6Frj482cgnk6NzG
	a96OtqyZdrLUH/ZorZjz1S43qwtg9JxRP2RgxbRAz8wRJ1r/uXYApGqgRNjxMBtnQ2R38Hzhf+s
	3dwe7l7XpsIhizyS2LqsB3h9Kw5Y3k2YV+vg/SCJ1pvHSTZZ8vpC8+eWlsRG9/TTY1qgQNDSDun
	2s/YmGwF46efh7TB7mJ2Y/SO3p/7H8
X-Gm-Gg: AeBDieueHtiOGQJX0t+agmUxivEpZt/3AsOosI69oBVt+rfiFOtxo0n2D2aWDCQMSsL
	TmXbpJxuhMjrunyFEd14B1HpiW4J5BvTAo23EY6Gq1I2RFmOljrMjTpExmqbg/csp7tO5sRYaEz
	pfHInqrI/96/78KJQ0YMTMFI2knXDG8MUdcH1uqBkhIrFIyr3q0X/nuZar+8I2cv6Pb8JAVyUhg
	QUuyZtEk+jMz5qjLLtfPJgTZUCyakPOiGmZ69L3Ud1zOSKXZTwYEbb1WnEVqyYOGLGlQD/nEDxg
	5U/tXSwyd4LBNeF0Okw=
X-Received: by 2002:a5d:5d87:0:b0:43d:a37f:8d5c with SMTP id ffacd0b85a97d-44bb490ee0amr21175127f8f.17.1777959108814;
        Mon, 04 May 2026 22:31:48 -0700 (PDT)
X-Received: by 2002:a5d:5d87:0:b0:43d:a37f:8d5c with SMTP id
 ffacd0b85a97d-44bb490ee0amr21175083f8f.17.1777959108379; Mon, 04 May 2026
 22:31:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428110946.11466-1-pbonzini@redhat.com> <dbc9f517-bd57-4c1c-a638-c33bb83a1171@proxmox.com>
 <CABgObfaFeK4kJpMGuki2hQxnz2ij8Nyyk0egxEfW4b_OYf9hgg@mail.gmail.com>
 <1a7c35d8-d7fe-4eec-ad83-da92780b62ce@proxmox.com> <90DA3B4A-633A-495A-8118-90BD26744230@nutanix.com>
In-Reply-To: <90DA3B4A-633A-495A-8118-90BD26744230@nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 5 May 2026 07:31:34 +0200
X-Gm-Features: AVHnY4Jm0OPG6JEqAwJh-BpC3JPxxQYxvT8sHVWjXVu40bdfkptoIpbnyoCpBA4
Message-ID: <CABgObfZscNDE+4L3RiBJ4nzQbG29YhM8fJWd9tLNd2c8g7XGeA@mail.gmail.com>
Subject: Re: [PATCH v4 00/28] KVM: combined patchset for MBEC/GMET support
To: Jon Kohler <jon@nutanix.com>
Cc: David Riley <d.riley@proxmox.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 3:14=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote:
> Paolo - Any chance you=E2=80=99ve got the next series ready? I can get th=
at
> into the QA harness on our side to beat it up. I was going to do that
> with the latest series now that I=E2=80=99m back from holiday, but figure=
d
> I=E2=80=99d ask since there was discussion of some fixups with Sean last =
week?

Yes, I've already placed the final (?!) version in kvm/queue (not
kvm/next exactly because I was going to post the version with the
fixups!).

Paolo

