Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC9B479895
	for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465375; cv=none; b=Whj4d6ttPl9xzeYTEh8i9RSQ8KHibXR/8c1GHu5i2CqZuZ/kCgfNK2mPu06CQucv8avnT2qAOnQ6P7u0Y5MxiCN0Ys/jLsnS+OoP2DDcoEoh43iSrt8GcBBSl5TBaM5nlJ8xKO+bjPuj52wJIEks+t92Xl3KrAom2B52PzWrgm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465375; c=relaxed/simple;
	bh=uCvoUHgJLkGvyYy/c5odfUayoHkL5waDu8y6yeP79iM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dm2o77MP0RxzsTsNfYt0/+F9iltlkiQ0/+M59B+wpoxXP/+8yDJttJ4viVUOIUfaF3OrJquKhYS8zbJ6mSSKHqFsfqaDpCCRHgyyhTlYWCdDZ7sx+N+Z6xu22kuuEfWfPF7zbpCHyk5ih3KiccXzWbBHWGh+UhRj4LSEf4BiKvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cz3DpKtc; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cz3DpKtc"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d9004a1ac0so475725ad.3
        for <kvm@vger.kernel.org>; Tue, 15 Sep 2026 02:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789465371; x=1790070171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FM6LpgS9VGFb0LQ0PAPpvOnM3tsCZP2CYIZnpcmqmZc=;
        b=Cz3DpKtcY3o3gcd6pKt/5EJBSkb5nikXLeP0NjHJELl/dhrxYrO0Q/tS+6SxjX5gpw
         lwK+PWPHf2kAHKg+x7VvUN7Ty3f1CEQoNPmUf8W4wNOhPcReDSkquB6IK9XczAdxmO1H
         7rbRhKUsu5WI8dvqcC0KEI0S5tkGBATG11relaG02ZasA1vCOm1Xsnx97eOISvcCVVab
         pNbW9XtWF69roObeAPWC4VYO50liZ20FpOrLctEm5NxvsP+0pCfFA4GsYESHWv6IMVgU
         g4p4dZO7Hf4RypfPiVZ0l28OlUd7Hri5fINeF0S1ScJ9xdxIapTr559rSkX+QVMLkwm0
         /mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789465371; x=1790070171;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FM6LpgS9VGFb0LQ0PAPpvOnM3tsCZP2CYIZnpcmqmZc=;
        b=mIZEfMoj2BEmATt9mHOnYMndhLvDUrJ+RJRbQNeKuZxINNeI337Y6+n72bjzRwvqO5
         zbZKgbdbvtKpfjAzPJVNRhfXmDYB8yRodq5th3Z2Py8zSC/EK75GjiAmyp8S66W2umpB
         /7mlKcwdIuE0wJjNow897PVoLXWgy+ZOkTvd5qXcE9qviH5DuUVuduwolwS00e0aSO2S
         tE7q28L7YDdmvRKV6F9uG9LY6+AoU+BWXqNkPOykiYo1T28rJVo4n2mM64wFQ/OprWiT
         uAoq77Guraa7DB7VIRqBRlzIOGJSjOR5ItJeymJu3/EoXvoPRhg/zEwd2dg3+Se+9kjk
         VN+g==
X-Forwarded-Encrypted: i=1; AKwUvBzEurr8lMBs/QjY00XKiYvp37pCwL2dgPljIKDEmX7sieBA5CUWu+Kz9Yzp0KIWCSZzRHQ=@vger.kernel.org
X-Gm-Message-State: AFuF++npRamiN5MfC/j+a683zPm7DaW5z3RIYImdBqs7PHdQgPLl26BP
	IRVInWYdV46KgyiLgUK+UreL87f2hQltbPuLKiCWWuAfUy0udlpiffV6
X-Gm-Gg: AYBFou0RnUeWOj0etQ67A9mXlHwYbB3HzrEINPTq96k12q+e2otMrTTsdl35mKdKs2w
	AmAGTZenxXzTNVpu235Z+nYclkrThIppvKoe5LBCBkc8ZzflwhZNjSKiAi2tdI+EKTYbxtzdXtD
	F8dzA/MsAUkTt71wg2tt3i2Ot1oR8dYY5y4npXYdRQxLyow4YADo3Jpq3lagtCwRxctIAmh0QwD
	Ce4DfJ4ZNHIborL3lyATCSPD9TsB1pj9YihPqQyPekEXdRaPfwwyLdZsGtNVDFXSiBOFOhhcLlE
	iAmh3K+lmahdx8QSLnPg9lxZXNnrZNyJ/Qu/0zWVinPBxT3scUohw7PIAv0QrtZej0vXSRCslf5
	pVv9UxzL76vEnpttrPCwKMBtWJfU9gMpdMLVzdZaVmLNEptr94VGLgynQlq3M2yeHqn/LyVoR0q
	SgEAz/BJowLhnxEdnvg+sTZ2QMlw3nu4qsBceMm7aUS/zYLFdYSFI7suLPyR2oMgA=
X-Received: by 2002:a17:90b:3c4f:b0:39b:4877:ae90 with SMTP id 98e67ed59e1d1-39e110770f7mr236150a91.22.1789465371127;
        Tue, 15 Sep 2026 02:42:51 -0700 (PDT)
Received: from jia ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdcb54d8sm4196291a91.6.2026.09.15.02.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:42:50 -0700 (PDT)
From: physicalmtea@gmail.com
To: mst@redhat.com
Cc: jasowangio@gmail.com,
	michael.christie@oracle.com,
	pbonzini@redhat.com,
	stefanha@redhat.com,
	eperezma@redhat.com,
	nab@linux-iscsi.org,
	asias@redhat.com,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] vhost-scsi: preserve event ordering and fix fallback deadlock
Date: Tue, 15 Sep 2026 17:42:42 +0800
Message-Id: <20260915094244.7900-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jia Jia <physicalmtea@gmail.com>

The vhost-scsi event list is populated with llist_add(), but completion
walks the detached list without reversing it.

Trigger: concurrent hotplug (ln -s). Each event is inserted at the
head of the pending list. Multiple events must already be stacked on
the llist before the vhost worker runs
vhost_scsi_complete_events(false). The whole list is then detached
and walked directly, so later-enqueued events are delivered to the
guest first.

Queued hotplug and hotunplug events can therefore be delivered in
reverse order.  Fix that ordering first, then fix the fallback path
that can relock the event virtqueue mutex while already holding it.

Patch 2 is based on patch 1 because both changes update the event
completion path. The first patch is otherwise independent of the
fallback deadlock.

Sashiko AI flagged this while reviewing
the vhost-scsi event queue fix.
This is a pre-existing self-deadlock. It was reproduced in a
follow-up test.

Trigger: vq->worker == NULL. vhost_vq_work_queue() then returns false,
and a subsequent vhost_scsi_do_plug() call deadlocks. I do not know what
normal condition gets us here; the normal vhost-scsi worker detach/reset
paths do not reach this code. The only reproduction I could come up with
was killing the vhost-scsi worker. This still looks like a low-probability
condition.

Jia Jia (2):
  vhost-scsi: preserve event ordering
  vhost-scsi: do not relock event vq mutex on send_evt fallback

 drivers/vhost/scsi.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

