Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779188;
	b=4fnqQXg11K03o441AtFHUsCT0zrG/OwiMaAXhH7/J/ivddB9t4VhidXxjoTcnaE64QhR
	 5TNj+/1urupdmEvnleFpZqHMrINs4DDk6KUcGj0VfSm+rhGSUmnhr47ECX68bFr1Lijgi
	 p5YqYS3eLTsZTGOgEbB/epEBHaXXSUU4kAtRpqji8iXl3sUNamVlsM/eBokFI1szwBl6y
	 FsP2keHjubkeMjY63/HVp6LekX+CMaxfaB2yd/er8c9xaS9JWhjzYjvhAqRMzScHthgy/
	 Eqh7GeNtsFAXVC9Jgm53iPQOhcsxkqMwFfTj4DGLEURIDbE4dpTdd50CiAl968V6cTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779188;
	h=Received:DKIM-Signature:Received:From:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:
	 Subject:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=38+GiE1gBBjeYJ5/7keBc+DKIzPpXLrUWnUnNUTxShA=;
	b=E13EwpgePnfzGFa3C1fJ+HQBOSbSkBpJ3pqLWY/4Z/aRiP+5nfh5KlQ9hgL8O5gJKZ76
	 DzwvCOadHRH99VF344ZbkAV6+OAzvOz8iwQyhsMrv1P3Ar/K+EQqEXIXpuJQZBILq45qi
	 ePz3DkCQfkGCrro2Ro7ufunRsYntuGQGsPMZpp3SFsvSl4PdvufJHBReKSvjU9u+Kd6a5
	 K18gGYmkunIurjJpcWcJOarSdl25Obka/j7EDRJK4MmeLgICcsiwAgwfHKn+8lu9sgvxo
	 U5yxN1+Ivn6C6EJE8/a6c7mfB9KqBPk2uHQrugTEOTe4rovCp858cIsMAQBPiDzyfAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjfMnoJe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BD6606A31F
	for <kvm@vger.kernel.org>; Fri, 27 Nov 2026 11:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gjfMnoJe
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795779187;
	b=dhWFtPp4lsauXquMm+Tk+Ug8tzUciFyvRlBwlMZLGPDzVGEZ+DLRUmYpJKEtZLMOoXnd
	 v+07byqayDspaCjS2m9lfUQcbobHv0Fgj4LoaFd1jyjRj7Aq7+l56RA1fO5g+QLSjSiXI
	 FYl5//cJ4kf5itBYSZr7adfOID7YujlsbRTAi6DVTjlIsDZLZ1YdQRnsItAyUQHbXci+n
	 5oZNd7julrxyIcKyitppd8qvN2D67mr1sonLnb0MwSkLHZ6ZDYZJvQ/BpVHrW8bMZoAwo
	 3Opfr6ltzB2laHzcQeyzs/txVnhceyTWDXXFN8eQVsngOUTGNcqbfitVdf3cJYwTlow==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795779187;
	h=DKIM-Signature:Received:From:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:
	 Subject:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=38+GiE1gBBjeYJ5/7keBc+DKIzPpXLrUWnUnNUTxShA=;
	b=Cz6e1ozE+TQHFqdqu90I1fIBdPI7dcb6eLyAUA6Qveebe+nG7i/Whsa9qE45oewW9uXu
	 m8jbJYHJ6gmqL8cI5JGmj2OBx0iL/Z5ENbmRmgjlz3BdbTE74diQpECoiOyYoHkYRU7b1
	 fHIy9MX0BuFlwHt1UspIIwm9p2IpCWeQnAfH9rAWBEAHRzE+mK+IUDnso+GRP8WfppCLE
	 bYJfpzHWYPSUNStg9KGR+IVcJg/U8sE864lTdaWr4XieeOAXyprwBPzL9i1kW05FKLWGV
	 uviNaucAIxLCQ+e/wKDaCjy6HAaRlQLWxP3ux2OtycJVLe1LrzGmKssicCM/jLTn8UA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 148101F00897;
	Fri, 27 Nov 2026 11:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795779187;
	bh=38+GiE1gBBjeYJ5/7keBc+DKIzPpXLrUWnUnNUTxShA=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=gjfMnoJe0EP6s2XTY216Ce3ZNchUCMMYh809jbQPRWD4A61VBBPu5BMLaRkCWcTHQ
	 fAeBKW+EwONzwH1ue6tyky4eb9Mpm30QXtlGbpWwBrdV1tmHMWsagLC5gJlvw6oCSu
	 pht4NdMnT0gxahlL1sjJVa7QIHEpmpcL1RQ4erxqmjZYcQsUyPhGcp0m5G/+w/T6R4
	 FfbFjTzuQuUHUFxIhQc70YAiBPFr9APT7U9PuOzR1Lz6hEvsYs5Ltcobv/7JcstxEU
	 5sq4swWS6Q/W4bwRt6T1wYduASUN7qE5HUX44gsnSix33kfCBqZ+6WfydmifecTq56
	 8shVmB+WVd8sg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 982F44B776;
	Fri, 27 Nov 2026 11:32:59 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Date: Fri, 27 Nov 2026 11:32:05 +0000
Message-Id: <20261127-kvt1-virtio-d-v1-0-bfa9ce1cece5@certik.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADVqCWsC/yWMSw7CMAwFr1J5jaWkhZZyFcQiH0MNKEFxiJCq3
 p0EljN6b1YQSkwCp26FRIWFY6igdx24xYQbIfvK0Kt+1Lqf8FGyxsIpc0SPx1lNo1OHYd4PUD+
 vRFf+/Hrny5/lbe/kcou0hTVCaJMJbmlKKPgc4xObh237AvLQLY6RAAAA
X-Change-ID: 20261127-kvt1-virtio-d-89076c053943
Subject: [PATCH kvmtool 0/3] virtio: Bound descriptor chains and validate
 9p requests
To: will@kernel.org, kvm@vger.kernel.org
Cc: julien.thierry.kdev@gmail.com
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795779125; l=2290;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=5j1JHFdkrf5uc9J1afcnODHnb2r+3e6F5MbaYBCSiKs=;
 b=rVZWSDgTtBXF/rSF0G1omd09zxQ+yVdLz0tYYDCjtX1SZ1fsXpYGwtxttW9wGUdxgftRs3EhK
 jp+p7YqfWEyBv6ftc9GUHEVLrzJLKlWPrRKgK4PKN5vBHOwCEVPf5ey
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

Hi Will, Julien,

As Will asked after my private report, here are the fixes on the list.
A guest that controls its virtqueues can make descriptor chains exceed
fixed host iovec arrays, place descriptor tables or buffers partly
outside mapped RAM, supply malformed 9p strings or I/O layouts, or
notify queues a device does not have. Reaching these paths requires
kernel-level control of the guest.

Tested:
  - On kvmtool master 2f3abe56dcd2658dc6dae3eeeb4996dc4b518bcf,
    the default -Werror build and 9p, net, RNG and balloon guest
    reproducers ran on real lkvm.
  - With the three patches on that master (tree
    51a74622257779e94627f721b2e51bc51d23d627), the default
    -Werror build, net valid and split RX, balloon valid, split and
    oversized statistics, and net/9p guest smoke passed. Smoke moved
    network traffic and created, read, wrote, renamed and deleted
    files over 9p.
  - A paired MMIO selection probe on master and the patched tree
    showed invalid selection on master and safe rejection on patched,
    with x86 MMIO enabled only in test copies.
  - checkpatch --no-tree --strict is clean on all three patches.

The reproducers are available if they help.

The bugs were found, and the fixes and test runs were
prepared with AI coding tools (OpenAI Codex agents, with review by
Claude). I went over the result before signing off.

---
Dickson Wu (3):
      virtio: Bound descriptor chains and guest ranges
      virtio: 9p: Validate unsigned string lengths
      virtio: Reject invalid 9p buffers and queue indices

 include/kvm/virtio.h |   9 +-
 virtio/9p-pdu.c      |  61 +++++++--
 virtio/9p.c          | 345 +++++++++++++++++++++++++++++++++++----------------
 virtio/balloon.c     |  59 +++++++--
 virtio/blk.c         |  18 ++-
 virtio/console.c     |   9 +-
 virtio/core.c        | 290 +++++++++++++++++++++++++++++++++++++------
 virtio/mmio-modern.c |   9 +-
 virtio/mmio.c        |   5 +-
 virtio/net.c         |  57 +++++++--
 virtio/pci-modern.c  |   3 +
 virtio/pci.c         |   9 +-
 virtio/rng.c         |   5 +-
 virtio/scsi.c        |   3 +-
 virtio/vsock.c       |   3 +-
 15 files changed, 679 insertions(+), 206 deletions(-)

base-commit: 2f3abe56dcd2658dc6dae3eeeb4996dc4b518bcf

