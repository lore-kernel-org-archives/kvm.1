Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20064F402F
	for <kvm@vger.kernel.org>; Mon, 19 Oct 2026 13:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415144; cv=none; b=Qkl2LaqJ1JWcQygIe4phRM99Q3wZ+uhaAtON6SBh9zLUKgZ1toxFnjBtxABfJ6J3v2aEUhj2A34zG6Wmkij63Ylv4IlPq811AJs7X1E93bsM/nSjHzX6zXVL2dKUQSnOv3rAEUsilpAuc2y/d0/UzM583yS1VJA+YH12vUgEX1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415144; c=relaxed/simple;
	bh=YjwPHevZQRNcLzJWtyHuFf40qjBdsRaMXi1C5dnfxRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lkkj4xE8GCFC+mv3vCV6qNphMRaAiDfYmrHCIXcKZw73MM136qb0SvVIsBAdTR+orQ5fjYbWNSp1rp4hEoDArZ5JSYb/O2sPiflbKU9zHnvgRPVEqXrV91q6vPeufGVamAyiorlTig/3xp8XhsBqhvr8ypXmra7owiByDLpDhqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LwvksZcm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LwvksZcm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792415142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kV7Tc7mRNwSqujjo1xPDFzUdbavaM8JaxSFB36oeQtg=;
	b=LwvksZcmdCjjx/eKw3w9LYXX3gYwXZS9SLPGoG5dGVcYCG36sclk55Vxk1CxZyP/bm7FS+
	U1pbKxmuNHDtED+sJAC2bAL04cfrLXXZCzVL2h+R8qkp58EKtj4eiQ40Ej30x15Dz0WN95
	tiqldiYXgIr81qxGKhJqBQhG/8HfwAA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-VBlEnvoDOcGZ2wnIaLwvqw-1; Mon,
 19 Oct 2026 13:05:37 +0000
X-MC-Unique: VBlEnvoDOcGZ2wnIaLwvqw-1
X-Mimecast-MFC-AGG-ID: VBlEnvoDOcGZ2wnIaLwvqw_1792415132
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 004D31954B3B;
	Mon, 19 Oct 2026 13:05:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF4A47E2;
	Mon, 19 Oct 2026 13:05:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 706FD21E6A04; Mon, 19 Oct 2026 15:05:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
  Michael Roth <michael.roth@amd.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@oss.qualcomm.com>,  Alberto Garcia <berto@igalia.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Zhao Liu
 <zhao1.liu@intel.com>,  Jonathan Cameron <jic23@kernel.org>,  Elena
 Ufimtseva <elena.ufimtseva@oracle.com>,  Jagannathan Raman
 <jag.raman@oracle.com>,  John Levon <john.levon@nutanix.com>,  Thanos
 Makatos <thanos.makatos@nutanix.com>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,
  Marcelo Tosatti <mtosatti@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,
  David Hildenbrand <david@kernel.org>,  Cornelia Huck <cohuck@redhat.com>,
  Eric Farman <farman@linux.ibm.com>,  Matthew Rosato
 <mjrosato@linux.ibm.com>,  qemu-block@nongnu.org,
  linux-cxl@vger.kernel.org,  kvm@vger.kernel.org,  qemu-s390x@nongnu.org
Subject: Re: [PATCH v5 17/62] qom: convert struct properties to QAPI-aware
 registration
In-Reply-To: <20260911-qom-qapi-v5-17-7732a55b7760@redhat.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 11 Sep 2026 20:34:51 +0400")
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
	<20260911-qom-qapi-v5-17-7732a55b7760@redhat.com>
Date: Mon, 19 Oct 2026 15:05:28 +0200
Message-ID: <87ik2xzvqf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Convert all callers of object_property_add() and
> object_class_property_add() that register struct-typed properties with
> QAPI visitor-based getters/setters to use object_property_add_qapi() and
> object_class_property_add_qapi() instead.
>
> This replaces the manual string type name with a reference to the
> generated QAPITypeInfo constant, enabling QMP introspection to report
> accurate QAPI type information for struct properties. Existing
> getters/setters are preserved unchanged.
>
> The cxl-fmw property type is corrected from "CXLFixedMemoryWindow"
> (not a real QAPI type) to "CXLFixedMemoryWindowOptions".
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  authz/list.c              |  2 +-
>  block/throttle-groups.c   |  5 +++--
>  chardev/char-socket.c     |  3 ++-
>  hw/core/machine.c         | 11 +++++++----
>  hw/cxl/cxl-host.c         |  4 +++-
>  hw/remote/vfio-user-obj.c |  5 +++--
>  hw/vfio-user/pci.c        |  5 +++--
>  target/i386/cpu.c         | 11 ++++++++---
>  target/i386/kvm/tdx.c     |  4 +++-
>  target/s390x/cpu-system.c |  4 +++-
>  10 files changed, 36 insertions(+), 18 deletions(-)
>
> diff --git a/authz/list.c b/authz/list.c
> index 363b2ee12c98..ed3d346004c2 100644
> --- a/authz/list.c
> +++ b/authz/list.c
> @@ -128,7 +128,7 @@ qauthz_list_class_init(ObjectClass *oc, const void *d=
ata)
>          .set =3D qauthz_list_prop_set_policy,
>      ));
>=20=20
> -    object_class_property_add(oc, "rules", "QAuthZListRule",
> +    object_class_property_add_qapi(oc, "rules", &QAuthZListRule_type_inf=
o,
>                                qauthz_list_prop_get_rules,
>                                qauthz_list_prop_set_rules,
>                                NULL, NULL);

docs/devel/style.rst (for what it's worth):

    In case of function, there are several variants:

    * 4 spaces indent from the beginning
    * align the secondary lines just after the opening parenthesis of the f=
irst

    For example:

    .. code-block:: c

        do_something(x, y,
            z);

        do_something(x, y,
                     z);

        do_something(x, do_another(y,
                                   z));

Thoughts?

[...]

