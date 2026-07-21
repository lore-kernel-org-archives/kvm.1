Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6530643C7DA
	for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 23:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675271; cv=pass; b=PkNSKExT/BMbXEpuwUra3DMcTbxfLSTgEVlA0TUWi6RFbaCSlii9U91H14+3EGhjeht9TPD+mieUwMjSN4uB+Geu7j7mfPwQdTy6kNmAPuExHKRlZOXW6Dc9yGPRKJWj9ccrN5pY6BbfsJgeOE7nIdyKpiiFYLAGnozLWnNHfmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675271; c=relaxed/simple;
	bh=3OQXXVa58whyMEmCorMBVgdW3liv+RGIOlQFgF8uhhs=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Content-Type; b=RfIinNGEE1CKRoWVq1TJanDJXjUNM9ecSkAACudBxIguGBwSlvQ/796JArjqOwDmAY/Zf2a04DCqLousC9uY3nchTbO+8E8EkQ1ocp9UN57KoLNS2qJiaATXBIpj/ARB9lx1kFznW/m9i+8LcufAiYEwCjXj19PDL8wMLNou+1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rf1quIOc; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rf1quIOc"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so7597040a91.2
        for <kvm@vger.kernel.org>; Tue, 21 Jul 2026 16:07:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784675268; cv=none;
        d=google.com; s=arc-20260327;
        b=j3L7uvITkcNoWgaFElMLowgN5Xn7LA7PFSIj8RvlFTmro0LQWW+HpeXd72VDmBWrFQ
         X3LByGYsw/m+C1LgwOrX0/xRkLMLh55teUOJsCJxiNZcDYUH68q4pEZRpRJkPm7WQIMv
         b4FXtAentgGrF2CWtfMvOXXDKRbY4PZOePu/invPChUWdhwHIdhAb9EeTFwsDaehZiUG
         oYX81I6uKhf3tJkpChOZoWov752t4EY2DHrwcwIDF9JNX6YdJ5Xt8Wh9imteYXAoQviG
         hpIPYlsG17ARHokOyYcKrNONyrLytbJw4xElTcJmDOdi5nD/B33JWT8hJlppiCTZWV5I
         OfOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=3OQXXVa58whyMEmCorMBVgdW3liv+RGIOlQFgF8uhhs=;
        fh=zZ8GMEn8hBTbk1WrxX+GVqLoEQaAG/MkbtH5yYA1ayw=;
        b=hXi7QZcjelMuEClmNQJ9nQ/Y3zcc2+yAAS2vuye3597Q+JgZhT3baFNUqCRMvCxrGc
         cDZ9+NEehp/8Qgbh4sq4hnwPL9Kt154F5RPXGUsU5F13Mtmx45sQZ8oVoCluw1P7bLrP
         VBEn3drjOvcg7Rdtz6FIlLLgX3TodCfPUJVBNzJTKhpFATeQrJoEwNvFEB2RoSbomHUl
         oO5J0R0PP+KcIs8ZbswbZJrk++SoGnidSGDJ0vMbpPPfQI10N/x/JkFB5Xc279s3ubZx
         QMRYmWdG4HfKByvULtwYh52Qnwb5VrNyKllihAUl17fltrh5LF8Wgdi3XPCCQAnMgl7A
         9R9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784675268; x=1785280068; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3OQXXVa58whyMEmCorMBVgdW3liv+RGIOlQFgF8uhhs=;
        b=rf1quIOce0kG2Bkz7e2a+RwtlIJ4C6FHWGDr+mraYfmI6LJjPo0fI2xXApRjXAajhx
         sVDBULhbwu7YaMSghF5MgLLenO0ZSJX5rtH858DsjgvACsWBVnVf1X6yvow8wl1n8hJ1
         ugmfUBWfNbf9iw56RzhD/lvtqxCN+0p1LkutxZ33XGtZdoan0rqD1ng98QqHLt+95jod
         2zjPRFukp/fCaIWmhlFwwZZCZdVQq+XyI01tb94Ki7g/SrI5YAYpwDWi4dlaaIv7iNpa
         BL1+EazYgTg/3F+GcQLuU3tUJUc36zNs185nI+7yCy1wNr3R88U3879VOJnkRwgG7ewt
         VhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675268; x=1785280068;
        h=content-type:to:subject:message-id:date:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3OQXXVa58whyMEmCorMBVgdW3liv+RGIOlQFgF8uhhs=;
        b=ehdpNEl9aafi5towbrWWfPbICjYOZMmAaPZ0RIBVzdceEWZ7oZ8nb7cvj5XhBBdSjX
         0+0Rot3mbGAWGF4W8iBwGDB7yIQOedTD2m26VieeuZhhQEGQurGIKvYURZXwQfOU5ikD
         lQMA1HuqsFIc9D9shnakHf+EryyPIkq58RZYiyYwh/BhspS+h8SG3T21Mkrq0BFtF92k
         y4cD6tlHYLDZtMa6E0Fc/hhn2ullVqf9RHnCQQfSUjrgV5anFo8chdwEcv0Ew5pnjMVG
         JQTDhnYfRSs4ZTiyOPnKIs9tnIhHcD2A59QS3WtZdfAzumeyAtGOsfRNfTDezfhwgelL
         29UA==
X-Forwarded-Encrypted: i=1; AHgh+RrvR/6ytgWqJen1znRu7uDDBay5DS+ArqSkJ+7mztZBFB61iyYAbUqTerxQ/3BWZ5kp1bA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUNiVsIGOEwKF7PY12z1t+cC/8ZBc4BREV9xe4jdvex8hX6KKt
	QeVYXl1HlZQ/i8FBjtKVzi3HgjeUU5UxZ2hD8IcbC1220E7kG9axlEWavgKe1mey6JRzQdpmcQh
	rVWydgpbDNAVfDzPsHFbRzZ4ZJFgkwYqhLGK65vU+
X-Gm-Gg: AR+sD119Beil9RuYDkTpo9n4Vg8O2gTYsiHcqRUCoiUH1C0jgjzi3B+NPcocBeaUfyb
	mBQ7zYrIhSQ5bAI3S167AB69aLyJQpYuyxb5yxDCY2wlqyJ7RNJvkKrJSDVKsk8i9nyV+7KwZ5d
	V9BvuinIYj1sh401v5bFvUdiSCCfIacbw5dzBFtcT0K2GthtMwncYsZRM11rBXaKNSHVIbwJijj
	veuKUgc+NdWzCceV33eq2VhbrMehI4O4D0Gzq4DPvkdx+2a2EQ0hEG3J4PF12/sKui7cGlVejhn
	/Yi3v8vk2uzo2p92lMaJNi4p853dKlMlBgIvyXzb0p1OGA==
X-Received: by 2002:a17:90b:1345:b0:38e:21da:9257 with SMTP id
 98e67ed59e1d1-38e4b56ed6amr22248144a91.37.1784675267895; Tue, 21 Jul 2026
 16:07:47 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 16:07:46 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 Jul 2026 16:07:46 -0700
From: Ackerley Tng <ackerleytng@google.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 21 Jul 2026 16:07:46 -0700
X-Gm-Features: AUfX_my9ZoAAGr2xVT-3ET2pTUKEhed6A55b3pp5x-TSu1YG-G0FttRwIwLL4RY
Message-ID: <CAEvNRgE74GL-pr6=GRpQWriGwXh6zsDP+ULxPd82GkFSQgjJkg@mail.gmail.com>
Subject: [Invitation] bi-weekly guest_memfd upstream call on 2026-07-23
To: linux-coco@lists.linux.dev, linux-mm@kvack.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Our next guest_memfd upstream call is scheduled for Thursday, 2026-07-23
at 8:00 - 9:00am (GMT-07:00) Pacific Time - Vancouver.

We'll be using the following Google meet:
http://meet.google.com/wxp-wtju-jzw

We don't have any scheduled topics as of now, please add topics!

The meeting notes can be found at [1], where we also link recordings and
collect current guest_memfd upstream proposals. If you want a Google
calendar invitation that also covers all future meetings, just write
Ackerley or David a mail.

To put something to discuss onto the agenda, reply to this mail or add
them to the "Topics/questions for next meeting(s)" section in the
meeting notes as a comment.

[1] https://docs.google.com/document/d/1M6766BzdY1Lhk7LiR5IqVR8B8mG3cr-cxTxOrAosPOk/edit?usp=sharing

Ackerley
