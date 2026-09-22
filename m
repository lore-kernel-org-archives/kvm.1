Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5915731B10B
	for <kvm@vger.kernel.org>; Tue, 22 Sep 2026 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790085070; cv=none; b=i6H0Lt0epe+OT1OeYduWYP4oROEFNqS+hsVgK661avomBxXyexiNcS7LwgodG8bTq54fuk75XbOF7i59/a68w0r2CDbcjBxcCBf5vyiOoJIxkqSObvkevYKwP061zpNuiDMOe7TYwSJ2h7PP++rHqmpDRaPv8LMoEInk1tA0hyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790085070; c=relaxed/simple;
	bh=N3s0/CLu9x9kPTF5rj7BgULZtfUw1x/XB4N0ngH9VKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIFdMsCtkusjqRklDK0/sKGL8rREXdDtf9xEgJuD1PSZydk94v37QMEbNGZGn9ET/vET5pasxqu8qu/fleKmyhkvw6viIQ3NvA8U3StmO1Ee/QsKkmjJ9Ris65Oho1YFda2JFUQuzAuoGdYvKqFICx6NEJ/6SOGjcg62Q/Ifh0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I0jcG3LL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I0jcG3LL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790085068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5BlNZBK01swwEKB8HxunMEnqdtD50qPALiXDq3bmCRI=;
	b=I0jcG3LLEAivHZlg7po+BHwseBJ1leRYakWVjRpVl9OWhFgqRPpZ4pdV7IXBkrM8AV6ql7
	2A64a0/3Jvy8iyHnHKJReeXYtXzZOcCdva/vUsMs6839LIFpcgwe7J/VGFuoxUPihmWSa0
	BtmIivBs3PXLRcJYCtDJMGgYVhAVTZo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-lO7ElBMZPFyhtr5-9RIz1g-1; Tue,
 22 Sep 2026 09:51:05 -0400
X-MC-Unique: lO7ElBMZPFyhtr5-9RIz1g-1
X-Mimecast-MFC-AGG-ID: lO7ElBMZPFyhtr5-9RIz1g_1790085064
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A6821806D3C;
	Tue, 22 Sep 2026 13:51:04 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B5866180056E;
	Tue, 22 Sep 2026 13:51:03 +0000 (UTC)
Date: Tue, 22 Sep 2026 09:51:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: seanjc@google.com, pbonzini@redhat.com
Cc: John Levon <john.levon@nutanix.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Thanos Makatos <thanos.makatos@nutanix.com>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] KVM: optionally post write on ioeventfd write
Message-ID: <20260922135102.GA24134@fedora>
References: <20260306125651.2485-1-thanos.makatos@nutanix.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8bQN+NXdpsvnwnuP"
Content-Disposition: inline
In-Reply-To: <20260306125651.2485-1-thanos.makatos@nutanix.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

--8bQN+NXdpsvnwnuP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2026 at 12:56:54PM +0000, Thanos Makatos wrote:
> Add a new flag, KVM_IOEVENTFD_FLAG_POST_WRITE, when assigning an
> ioeventfd that results in the value written by the guest to be copied
> to user-supplied memory instead of being discarded.
>=20
> The goal of this new mechanism is to speed up doorbell writes on NVMe
> controllers emulated outside of the VMM. Currently, a doorbell write to
> an NVMe SQ tail doorbell requires returning from ioctl(KVM_RUN) and the
> VMM communicating the event, along with the doorbell value, to the NVMe
> controller emulation task.  With POST_WRITE, the NVMe emulation task is
> directly notified of the doorbell write and can find the doorbell value
> in a known location, without involving VMM.
>=20
> Add tests for this new functionality.
>=20
> LLM (claude-4.6-opus-high) was used mainly for the tests and to a
> lesser extent for pre-reviewing this patch.
>=20
> Signed-off-by: Thanos Makatos <thanos.makatos@nutanix.com>
> ---
>  Documentation/virt/kvm/api.rst               |  13 +-
>  include/uapi/linux/kvm.h                     |   6 +-
>  tools/testing/selftests/kvm/Makefile.kvm     |   1 +
>  tools/testing/selftests/kvm/ioeventfd_test.c | 624 +++++++++++++++++++
>  virt/kvm/eventfd.c                           |  23 +
>  virt/kvm/kvm_main.c                          |   1 +
>  6 files changed, 666 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/ioeventfd_test.c

Sean, Paolo: Ping

I would like to enable ioeventfd support in QEMU's NVMe device emulation
and this requires POST_WRITE for Windows guests (they don't support
NVMe's Doorbell Buffer Config feature so it's necessary to capture the
latest value written to the doorbell somehow).

POST_WRITE applies to any device that has a doorbell register where the
latest value needs to be captured. This looks like a reasonable
extension to ioeventfd.

I also looked into alternatives, like using userfaultfd, and didn't find
anything better.

Please consider merging this. Thanks!

Stefan

--8bQN+NXdpsvnwnuP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqyh8YACgkQnKSrs4Gr
c8jkfgf/Vt7HqaxQAJrLNOr3ltePbuJi29oDwhhqkNMrcj3s6GHLCtGZ1IMah1Mu
8daFd4jV0WJp6YoCbYOnwqMbfp6xUsaj2NNtdmOLISZazydliCQ7dtnzP9g7sORI
uItikSDtoGis6hnz6YghQyxgXUDSStwKoUV95fm2ZVLJkGqfnGHnCATPYd90lOyB
TKbTTuWMBhTJ+cH5ay1YjeNL8UVRHaAeNaNJSCeOtfjqzx+xHiwIs+6Q/SHNaUG7
lGX8Dgf24LvxX/++SkgVo9xLBtXefQeqYc+URFv2WfzNYMQYIb3B4vhfFec/wd1B
jwC6Fb+bqeYC7cwOHknDJtf+zYBV7w==
=kCxL
-----END PGP SIGNATURE-----

--8bQN+NXdpsvnwnuP--

