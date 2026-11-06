Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971143;
	b=wDsp7EWJE3Rm4iAEL9S6HH47na3O8jgEFaH0ZnF6oUovzyLY6DZnBLDjxDthxAdcwUIn
	 BopO+uYkZ+3ASTG3fmb3YAOZobpUNr5GjZo6i+kk1FTHnwrRb/wgUOvOqWlZjr5+ZSu7x
	 +I3J7K6kosKAgyriBQ1x9LoM5t7eNOu8ggoFE/8v/Zfi3pgv+SD+9fLZeGHwVuu3AVQK7
	 bKjqD17BGRR7mbLTREB3pEWVpbB/yL3wZfuVaYBhJf7/rLBGTYev4q1BQiW5ADJOvfpoj
	 G5z9l2GPDNCzYKgM7SAMr/JOM8Pger4zNCAKa3ir13Vw0Tm2mvL4P95Jg0Br0eagyaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971143;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=q5je5xTRpjfx4LjGIZHPjYuGaotAGI4cWt3i0iD11+Y=;
	b=gW/s8D7lhnHxIicr2AD/Z/KOKJXRLP4FbB4+m3NLHGCB2exC34VSk6mUvk0RNQ/6w5ip
	 aSd/ue0TmjdIwURNZYSYjDpoFCI6bNloWlUbHrYfJk8u74hsTwfiOMnek8tATUkG4ADx3
	 mFt2N7riKhVzrYJ4CTtbYyCMvh09G4PohCvWskFbIQ1YuAzvFCgDX2hJvGzKNqYs1MwDx
	 bDiV8WmiywDpWTIEryunFyebqeBeVU/DiacQI++xXOBGT4R6md8nxfiaF2l1zl65mHIC9
	 4rnGT8rlVbrnNfwrKzTWRWJpHukIP/kakZc4UmvEMcXGfAjZjTGjZS5WKnZ2EFJEJQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=b3PIHqeQ;
	arc=none smtp.remote-ip=91.218.175.33
Received: from mta0.migadu.com (out-33.mta0.migadu.com [91.218.175.33])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3D0606A330
	for <kvm@vger.kernel.org>; Fri,  6 Nov 2026 13:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA3D0606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=b3PIHqeQ
X-Envelope-To: kvm@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4zwexF7Wz01Eu+onBHbqwklyRz49GNwu5fYWiMpNDo0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793971140; v=1; x=1794575940;
 b=b3PIHqeQrojtLU4Y4VNCZ8rRt61bMFIDsLuTUcbsprTA2BhGn7Ms48fbXm2i4k5LuneFaPZL
 efns+y5W7XbtNLWmXja8lX760spiEjNqVLTfDK+0ec9BwB0YmskmQOe7C4oP0x7xojKGDPefOnz
 x3cM79fsW0CNI8761sGgxJNA=
X-Envelope-To: kvm@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 26aa00f910ee51dc;
	Fri, 06 Nov 2026 13:19:00 +0000
X-Mizu-Trace-ID: 26aa00f910ee51dc
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: akpm@linux-foundation.org,
	dgilbert@interlog.com,
	mkp@kernel.org,
	loberman@redhat.com,
	jmeneghi@redhat.com,
	kraxel@redhat.com,
	vivek.kasireddy@intel.com,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	rostedt@goodmis.org,
	vdonnefort@google.com,
	mhiramat@kernel.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	axboe@kernel.dk
Cc: linux-mm@kvack.org,
	James.Bottomley@HansenPartnership.com,
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
	phasta@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	linux-scsi@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bobbyeshleman@meta.com,
	mathieu.desnoyers@efficios.com,
	robin.murphy@arm.com,
	mason@kernel.org,
	aesteve@redhat.com,
	tjmercier@google.com,
	harry@kernel.org,
	vbabka@suse.cz,
	cui.tao@linux.dev,
	cuitao@kylinos.cn
Subject: [PATCH 0/7] memcg: account the remaining uncharged kernel allocations
Date: Fri,  6 Nov 2026 21:18:22 +0800
Message-ID: <20261106131829.3228926-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

Kernel memory that scales with user controlled input is supposed to be
charged to the memcg of the task that induces it, so that memory.max
contains the damage and the accounting is honest.  Sweeping the
interfaces that let unprivileged or delegated users drive kernel
allocations turned up seven more places where the charge is missing.
Every fix is one flag; the interesting part is who can pull the lever
and how much a pull buys.

An open sg fd reserves up to max_sectors worth of buffer, SG_MAX_QUEUE
(16) commands can be in flight per fd, and the fd count is bounded only
by RLIMIT_NOFILE.  udmabuf metadata costs about 4MB of SUnreclaim per
GB of buffer with size_limit_mb defaulting to INT_MAX.  vhost holds
roughly 150KB of resident kernel memory per SET_OWNER, and
/dev/vhost-net is handed to containers by device plugins.  A ftrace
instance allocates two full sets of per-cpu ring buffers the moment it
is created, about 1.375MB per cpu per set, gated by tracefs permissions
alone.  iommufd's hw_queue contiguity check allocates an array sized by
a u64 from userspace, frees it when the check fails, and can be
repeated in a tight loop.  io_uring still leaves the ring context, the
SQPOLL thread data, io-wq, the alloc cache arrays, the kbuf iovecs and
the registered eventfds uncharged.  The rsrc and tctx surfaces are
already charged by commit 075d5837bafc ("io_uring/rsrc: charge buffer
arrays and nodes to memcg") and commit 0b34e7b20a48 ("io_uring: charge
tctx nodes and personalities"); patches 6-7 pick up what those did not.

Verified on next-20261104 under qemu, same config with and without the
series, everything builtin: eight sg fds with 1MB reserved buffers
charge 8MB with the series and nothing without; resizing the global
trace buffer to 16MB per cpu charges 67MB against 0 before; four 512MB
udmabuf buffers charge around 8MB of metadata; sixteen vhost SET_OWNER
calls charge 4MB; 1000 io_uring rings charge 7.6MB on top of what the
in-tree charging already accounts.  All slab allocations in the series
are served by kmalloc caches, so they keep charging under the
SLAB_MAY_ACCOUNT opt-in rule queued in slab/for-next; the tracing patch
accounts page allocations, which are not affected by it.

Two in-flight series overlap but do not collide.  The dma-heap explicit
memcg charging series moves dma-buf data page charging to an explicit
path and removes __GFP_ACCOUNT from the system heap, while patch 2 here
accounts udmabuf metadata only, which that series does not see; if it
lands first, the system heap reference in patch 2 wants dropping.  The
io_uring patches sit on top of the charging Mason and Jens already
merged, and cite those commits as the in-tree predecessors.

I am sending these in one thread so the class is visible in one place.
If any of you would rather take your piece through your own tree, an
ack is all I need and I will split the series.

Tao Cui (7):
  scsi: sg and st: account the command buffer memory to memcg
  dma-buf/udmabuf: account the page array metadata to memcg
  vhost: account the per-device kernel allocations to memcg
  tracing: account ring buffer pages and trace_array metadata to memcg
  iommufd: account the hw_queue page array to memcg
  io_uring: account the ring context and SQPOLL thread data to memcg
  io_uring: account the remaining per-object allocations to memcg

 drivers/dma-buf/udmabuf.c      |  7 ++++---
 drivers/iommu/iommufd/viommu.c |  3 ++-
 drivers/scsi/sg.c              | 23 ++++++++++++++++++++---
 drivers/scsi/st.c              |  7 ++++---
 drivers/vhost/net.c            | 14 ++++++++------
 drivers/vhost/vhost.c          | 16 ++++++++++------
 drivers/vhost/vsock.c          |  5 +++--
 io_uring/alloc_cache.c         |  3 ++-
 io_uring/eventfd.c             |  2 +-
 io_uring/io-wq.c               |  4 ++--
 io_uring/io_uring.c            |  2 +-
 io_uring/kbuf.c                |  2 +-
 io_uring/rsrc.c                |  3 ++-
 io_uring/sqpoll.c              |  2 +-
 io_uring/tctx.c                |  4 ++--
 kernel/trace/ring_buffer.c     |  8 +++++++-
 kernel/trace/trace.c           |  6 +++---
 17 files changed, 73 insertions(+), 38 deletions(-)

-- 
2.43.0

