Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792477869;
	b=p4irLxTmGCFLMvSaoDKVOhjJVZgq5hkYrSsLeH+sh4WwwkIgkiFVUL7A71H8S8WYMj5B
	 vzSTZ0Xew/W16YoFtvlkf6L/O9LHzuw0j+Txi/QxK4i1uECJ20L7ah7eQ/dnm1UE3vu9A
	 W2y7tTiWJXdcI3/5I4evr6xD37APDBPu5CVhxb04K6SK0ilGV35rn9JJGMNtBvkRsWyRB
	 ZupKIzEkg6osEwNLJH+yxuXx+IzN7MSYVbQnIFBfkfWfWq+fv4KUOD7z7b1JeX9J8MNEy
	 ldob5oZkoeJFlbG6TavVPXhxW4+Lkzaky1R5n5u30xmsQe0F5EIfOyrZFvSpt99frbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792477869;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=byUfW4kLa5VquMzq/fU72LMKv+Nm6w7mdDd6FaonJuY=;
	b=CEllVDqYbADGyxVvDU4zwyW8jtcdQhKWrAVPE+PGuzkzydmdE45KJ7WQf13C8k4OKsCU
	 jUVk2z5qvjrUrt2avcXiaTirn1i7ZRH39+qb+3LSpEX4pGKoStA3n7TWNleJecCIWjP1j
	 nudkwVwxhNFlyQiIhQgeB9JqnjaGXGMnZmZCvP8dcV+XFYsLFYl7iEt6U2Hy6ksnfMsED
	 WisUacJ+vKVHkKDaxuuXWJgB4CLvBS1FxatPU+NcYRELYbO/+oxUexAnjDkd6W4B3AjzJ
	 usgHTLujgfB4QRAoL7FybFHpF53IzfVaxb9k66IGd6DN3uT4n0o4TNSBLocvaHaOV8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dg0MxZHM;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bE1fQ0Xr;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA8606A319
	for <kvm@vger.kernel.org>; Tue, 20 Oct 2026 06:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9CA8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dg0MxZHM;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=bE1fQ0Xr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792477867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=byUfW4kLa5VquMzq/fU72LMKv+Nm6w7mdDd6FaonJuY=;
	b=dg0MxZHMqZHioaJXg8ZkvOBR4u4pWTiyWAKZNKx3SWNkrJlXDogcGdLSivu0cpPaE6+Sa/
	GDBCrqAu7jGNK+YqaiOIE8MmA046P9rQeUvjE8s4vBu7DFo0AqeFguiKFQucz4hqN+ddtX
	JQ3JRgq1/9TeQGHDHU5v+SKEnJSI9I0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-z97jL4dEMbO_xGvlFDK6ow-1; Tue, 20 Oct 2026 06:30:55 +0000
X-MC-Unique: z97jL4dEMbO_xGvlFDK6ow-1
X-Mimecast-MFC-AGG-ID: z97jL4dEMbO_xGvlFDK6ow_1792477855
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48b01a74792so2081751f8f.0
        for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 23:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792477855; x=1793082655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=byUfW4kLa5VquMzq/fU72LMKv+Nm6w7mdDd6FaonJuY=;
        b=bE1fQ0XrrD5SciDTZcprPRRyeq0XAd6kEktstG38AewJCDrj+CUEcPPjJD8W30/XwR
         cesprwjN5c+0+Ihm7zm254TEOFmoENhQn0mO/WcBQgVvxB5WTPsVQ3vAZ1YQbmg1ln2n
         Cx54Vv4/D9K+nt1UFo4g4A9JszwKcdGnVvG/Emxc7TwVPEHirfmZxf8FflLPYegfKher
         YbxWXtQ3FE7+uBv0H8M0zigK1n0K6VEOQMSUsVas9zSM3qhrTu6/yHfYwblE7mUerp+7
         uqYwW0eD04cI1RCR9ZNhtUh8eJQ0JT9wBhDI7YduUqxyDrPnuagnlcOk4IFhOduF7k+i
         kpAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792477855; x=1793082655;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=byUfW4kLa5VquMzq/fU72LMKv+Nm6w7mdDd6FaonJuY=;
        b=rw9EZNmhQq0APPDZ78eLciNHwDWtcs2S3OgtY+ecZS5Eyr9VclHMw8S/wJjqu4942Q
         T0OkIwXK0ops15YxG/+c3oN152vO0oH6+g61W/G/ULwVtDlEbxsMOTSpnwslNBNzolYx
         /VjoEdbOTTyGzmvpOolDmnVJ1LywRQRBOfwLKis0hynbFKAkMGL4IWL/UbGiTJnHyDe3
         sGBfwMxBz9/JRgBqNhwROSv2cizf6zyYdwnmTwG3ctA7GICkPUFLyD/fO/HQx04i6ZUf
         uHVl00sBhDSpmHuX0zsDsdpHX00D2UQPQGjKkTY6mM6smjpdu7+bgMWJWw5Pl3Emewad
         rb8w==
X-Forwarded-Encrypted: i=1; AKwUvBy831T4hEIB2sJPHFnKRcvguFHBR3DUXxgvSup5VJH6Oa+xDQ6ry4kyQfzlnGkPwfjyuZA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvGT0XWfiE1OUrfjwDNzuY+/z6ge648JspN2N5xlDsIUf7Ts8Q
	xVZ2W0p+DUcZ4UnJObJI8Lod1z+fpwrgRbNZdNPrQ3uvkPt1zD1mNebyoNNubcJrdC555qObDtt
	yaIKdwXfsUrp9y4YQh12u5lCzSsTnjjVO3UFT/Wmzo/pyHeew97SFMA==
X-Gm-Gg: AYBFou3neuLkCZ6X8xWdtQWZdlMg0lRy9L1w6Rdqj4u9ojA9GIGRzfE/bW3GO4XA53u
	PrHXjIRdP09dvBVrxR+neBK5JV+w160eUIh5P5lWsSY4OndC8sFGYQ0Aa0BdO5OYy+pflRSNIBG
	b54VWDhzQIDFwf6fffBu+Ox0UUC3HOJiumvkb6KdswtNwTf5pnUxlqQwTH54JEafxtoymLoVJ9u
	Qh3Q0YxSCsEyfNjyyWcHJaGCQ+z5rl8IpX659leaXe/X0Ubom68BlzThvqCCRZbgELSvDrLmgr5
	SHLJcM7CPctM8SlTA/U2+m5461VzCpoPyI8VVY7oSTPSuy6HBjUkO8PjWTKNxeSddj7CKQ==
X-Received: by 2002:a05:6000:1887:b0:488:8437:b8b7 with SMTP id ffacd0b85a97d-48e07978bfcmr21309161f8f.7.1792477854587;
        Mon, 19 Oct 2026 23:30:54 -0700 (PDT)
X-Received: by 2002:a05:6000:1887:b0:488:8437:b8b7 with SMTP id ffacd0b85a97d-48e07978bfcmr21309119f8f.7.1792477854028;
        Mon, 19 Oct 2026 23:30:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8214e1sm3912561f8f.37.2026.10.19.23.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 23:30:53 -0700 (PDT)
Date: Tue, 20 Oct 2026 02:30:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wang Haoran <haoranwangsec@gmail.com>
Cc: torvalds@linuxfoundation.org, jasowangio@gmail.com, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	eperezma@redhat.com
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261020021924-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org>
 <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>

On Mon, Oct 19, 2026 at 03:14:46PM +0800, Wang Haoran wrote:
> Eugenio previously offered some additional suggestions in reply to
> my patch email. Should these also be addressed?

The following seems to work for me. Testing would be appreciated.

From: Michael S. Tsirkin <mst@redhat.com>
Subject: [PATCH v2] vringh: use get_user/put_user in the use_va path

getu16_iotlb()/putu16_iotlb() pass the address produced by
iotlb_translate() straight to __get_user()/__put_user(),
without access_ok checked anywhere. Not good.

Switch to get_user()/put_user(), which are always
correct, and safer.

But the fact is that accessing user memory like this
will sometimes (rarely) race with page being swapped
out, trigger EFAULT, and it should be retried
from a worker, and vdpa_sim currently does not do this.

Fixes: 42823a871fd4 ("vringh: support VA with iotlb")
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

Notes (changelog):
v1->v2:
    Use get_user()/put_user() wrapped in pagefault_disable() instead of
    access_ok() followed by __get_user()/__put_user(); the helpers are
    reached from BH-disabled sections, and __get_user() is not a valid
    way around that (David Laight, Linus Torvalds)

 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 2 ++
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 2 ++
 drivers/vhost/vringh.c               | 4 ++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 76dd5b0828d7..325ec8f0ab85 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -347,8 +347,10 @@ static void vdpasim_blk_work(struct vdpasim *vdpasim)
 			smp_wmb();
 
 			local_bh_disable();
+			pagefault_disable();
 			if (vringh_need_notify_iotlb(&vq->vring) > 0)
 				vringh_notify(&vq->vring);
+			pagefault_enable();
 			local_bh_enable();
 
 			if (++reqs > 4) {
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index a6514b5ccd86..964cdf422467 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -77,8 +77,10 @@ static void vdpasim_net_complete(struct vdpasim_virtqueue *vq, size_t len)
 	smp_wmb();
 
 	local_bh_disable();
+	pagefault_disable();
 	if (vringh_need_notify_iotlb(&vq->vring) > 0)
 		vringh_notify(&vq->vring);
+	pagefault_enable();
 	local_bh_enable();
 }
 
diff --git a/drivers/vhost/vringh.c b/drivers/vhost/vringh.c
index 9066f9f12ba1..74836eb60c7a 100644
--- a/drivers/vhost/vringh.c
+++ b/drivers/vhost/vringh.c
@@ -1213,7 +1213,7 @@ static inline int getu16_iotlb(const struct vringh *vrh,
 		return ret;

 	if (vrh->use_va) {
-		ret = __get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
+		ret = get_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
 		if (ret)
 			return ret;
 	} else {
@@ -1251,7 +1251,7 @@ static inline int putu16_iotlb(const struct vringh *vrh,
 	tmp = cpu_to_vringh16(vrh, val);

 	if (vrh->use_va) {
-		ret = __put_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
+		ret = put_user(tmp, (__virtio16 __user *)ivec.iov.iovec[0].iov_base);
 		if (ret)
 			return ret;
 	} else {

