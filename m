Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD3340BCB0
	for <kvm@vger.kernel.org>; Tue,  6 Oct 2026 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791290945; cv=none; b=YkpqGDVt3NbKJRSFq3ihcfMMfKRWCDreLrDHOCyFZNmJ1g5NDekWthKoQZlJcph4jktqOF73e9oo1pFmtB4hbDIN5yx/E9Psok+sHY3fwOHGJUOwf08U/vhvjDhwCT8ddSKg7vAkppGRCRMtEcSPz48puiEwhipNgvM4bOvfJBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791290945; c=relaxed/simple;
	bh=fh9GVse/ZIh3AH9u8G+heqxy1rVNKgc8CvFQ8ml3aeA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HP+84cW7oEvz9uaOxH9CYKuh7JUi5Qnd1wy58fWV+gk4ax3vrS4Ftf8IvFDMnRPNZsPy4uD6XW80w39u7DOfrcwQ3NfWXr+qDxfp/GDGHUWrYnwRnlxn4OSI0qYHQTXiSEEEt3H9nhfTIP8LOIxlquzJA41/Fb366CQOV3iM+9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.1] (unknown [122.194.100.201])
	by APP-01 (Coremail) with SMTP id qwCowABnP_Mh7sRqrYEHCg--.36719S2;
	Tue, 06 Oct 2026 20:48:34 +0800 (CST)
Message-ID: <d712f294a4e40eddc9796a5a14ceecc4393cec54.camel@iscas.ac.cn>
Subject: Re: [kvm-unit-tests PATCH 4/7] riscv: Add ACPI support for ISA
 string discovery
From: Xiang W <wangxiang@iscas.ac.cn>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, pbonzini@redhat.com,
 	thuth@redhat.com
Date: Tue, 06 Oct 2026 20:48:33 +0800
In-Reply-To: <it2vpvd5lo7rats2r6dbbtxyb4n4n5zwextkteccognilhzudj@7c5exktlyrr3>
References: <20260924033945.176581-1-wangxiang@iscas.ac.cn>
	 <20260924033945.176581-5-wangxiang@iscas.ac.cn>
	 <it2vpvd5lo7rats2r6dbbtxyb4n4n5zwextkteccognilhzudj@7c5exktlyrr3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:qwCowABnP_Mh7sRqrYEHCg--.36719S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw4xKrW7Zryktr1rur45Jrb_yoW7Ary7pF
	4xKrWYkrsxJws7Wr1aqw4jvrW3J348Cw1UJrsrJa4Fy3yqkF18XF4UK347uF1rJr1kWa12
	vr1DtFy7KF1jkrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
	AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5L18JUUUUU==
X-CM-SenderInfo: pzdqw5pldqwq5lvft2wodfhubq/

=E5=9C=A8 2026-09-30=E4=B8=89=E7=9A=84 12:15 +0200=EF=BC=8CAndrew Jones=E5=
=86=99=E9=81=93=EF=BC=9A
> On Thu, Sep 24, 2026 at 11:39:42AM +0800, Xiang W wrote:
> > When a DT is not provided, walk the RHCT Hart Info nodes and parse
> > the referenced ISA String node instead of aborting in isa_init()
> > and cpu_has_extension_name().
> >=20
> > Match the current hart by ACPI UID (DT still matches by hartid)
> > and feed the ISA string into the existing isa_parse() helper so
> > extension detection is shared by both firmware descriptions.
> >=20
> > Rename isa_info.hartid to isa_info.id so the same iterator state
> > can hold either identifier.
> >=20
> > Signed-off-by: Xiang W <wangxiang@iscas.ac.cn>
> > ---
> > =C2=A0lib/acpi.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 28 +++++++++++++++++++=
+
> > =C2=A0lib/riscv/isa.c | 68 ++++++++++++++++++++++++++++++++++++++++++++=
-----
> > =C2=A02 files changed, 89 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/lib/acpi.h b/lib/acpi.h
> > index 2597e8ce..3db382b7 100644
> > --- a/lib/acpi.h
> > +++ b/lib/acpi.h
> > @@ -337,6 +337,34 @@ struct acpi_table_rhct {
> > =C2=A0	u32 node_offset;
> > =C2=A0};
> > =C2=A0
> > +#define ACPI_RHCT_NODE_HEADER_DEF \
> > +	u16 type;	\
> > +	u16 length;	\
> > +	u16 revision;	\
> > +
> > +struct acpi_rhct_node {
> > +	ACPI_RHCT_NODE_HEADER_DEF
> > +	char data[];
> > +};
> > +
> > +enum acpi_rhct_node_type {
> > +	RHCT_NODE_ISA_STRING =3D 0x0,
> > +	RHCT_NODE_HART_INFO =3D 0xFFFF
>=20
> ACPI_RHCT_NODE_TYPE_ISA_STRING
> ACPI_RHCT_NODE_TYPE_HART_INFO
>=20
> > +};
> > +
> > +struct acpi_rhct_node_isa_string {
> > +	ACPI_RHCT_NODE_HEADER_DEF
> > +	u16 isa_length;
> > +	char isa[];
> > +};
> > +
> > +struct acpi_rhct_node_hart_info {
> > +	ACPI_RHCT_NODE_HEADER_DEF
> > +	u16 num_offsets;
> > +	u32 uid;
> > +	u32 nodes[];
> > +};
> > +
> > =C2=A0/* Reset to default packing */
> > =C2=A0#pragma pack()
> > =C2=A0
> > diff --git a/lib/riscv/isa.c b/lib/riscv/isa.c
> > index bc1c9c72..b0257979 100644
> > --- a/lib/riscv/isa.c
> > +++ b/lib/riscv/isa.c
> > @@ -12,7 +12,7 @@
> > =C2=A0typedef void (*isa_func_t)(const char *, int, void *);
> > =C2=A0
> > =C2=A0struct isa_info {
> > -	unsigned long hartid;
> > +	unsigned long id;
> > =C2=A0	isa_func_t func;
> > =C2=A0	void *data;
> > =C2=A0};
> > @@ -74,7 +74,7 @@ static void isa_parse_fdt(int cpu_node, u64 hartid, v=
oid *data)
> > =C2=A0	const struct fdt_property *prop;
> > =C2=A0	int len;
> > =C2=A0
> > -	if (hartid !=3D info->hartid)
> > +	if (hartid !=3D info->id)
> > =C2=A0		return;
> > =C2=A0
> > =C2=A0	prop =3D fdt_get_property(dt_fdt(), cpu_node, "riscv,isa", &len)=
;
> > @@ -83,32 +83,80 @@ static void isa_parse_fdt(int cpu_node, u64 hartid,=
 void *data)
> > =C2=A0	isa_parse(prop->data, len, info);
> > =C2=A0}
> > =C2=A0
> > -static void isa_init_acpi(void)
> > +#ifdef CONFIG_EFI
> > +#include <acpi.h>
> > +
> > +static void isa_parse_acpi(struct acpi_table_rhct *rhct, struct acpi_r=
hct_node_hart_info *hart_info, void *data)
>=20
> Let's keep it under 100
>=20
> static void isa_parse_acpi(struct acpi_table_rhct *rhct,
> 			=C2=A0=C2=A0 struct acpi_rhct_node_hart_info *hart_info, void *data)
>=20
> > +{
> > +	u32 offset;
> > +	struct acpi_rhct_node *node;
> > +	struct acpi_rhct_node_isa_string *isa_string;
> > +	struct isa_info *info =3D (struct isa_info *)data;
> > +
> > +	if (hart_info->uid !=3D info->id)
> > +		return;
> > +
> > +	for (int i =3D 0; i < hart_info->num_offsets; i++) {
> > +		offset =3D hart_info->nodes[i];
> > +		if (offset >=3D rhct->length)
> > +			break;
> > +		node =3D (void *)rhct + offset;
> > +		if (node->type =3D=3D RHCT_NODE_ISA_STRING) {
> > +			isa_string =3D (void *) node;
>=20
> =C2=A0isa_string =3D (void *)node
>=20
> I thought checkpatch would catch something like that. Did you run it?

Below is my checkpatch execution log; assigning a `void*` pointer to a poin=
ter
of another type passes the checkpatch validation.

=E2=9E=9C  kvm-unit-tests git:(brs-i_v1) ./scripts/checkpatch.pl -g HEAD^^^=
                                                    =20
WARNING: macros should not use a trailing semicolon
#32: FILE: lib/acpi.h:340:
+#define ACPI_RHCT_NODE_HEADER_DEF \
+	u16 type;	\
+	u16 length;	\
+	u16 revision;	\
+

WARNING: line length of 112 exceeds 100 columns
#93: FILE: lib/riscv/isa.c:89:
+static void isa_parse_acpi(struct acpi_table_rhct *rhct, struct acpi_rhct_=
node_hart_info *hart_info, void *data)

WARNING: line length of 102 exceeds 100 columns
#116: FILE: lib/riscv/isa.c:112:
+	void (*func)(struct acpi_table_rhct *, struct acpi_rhct_node_hart_info *,=
 void *), void *data)

WARNING: Missing a blank line after declarations
#123: FILE: lib/riscv/isa.c:118:
+	struct acpi_rhct_node_hart_info *hart_info;
+	rhct =3D find_acpi_table_addr(RHCT_SIGNATURE);

total: 0 errors, 4 warnings, 151 lines checked

Commit ca687690a06e ("riscv: Add ACPI support for ISA string discovery") ha=
s no obvious style problems and is ready for submission.

>=20
> > +			isa_parse(isa_string->isa, isa_string->isa_length, info);
> > +		}
> > +	}
> > +}
> > +
> > +static void acpi_rhct_for_each_hart(
> > +	void (*func)(struct acpi_table_rhct *, struct acpi_rhct_node_hart_inf=
o *, void *), void *data)
>=20
> static void acpi_rhct_for_each_hart(void (*func)(struct acpi_table_rhct *=
,
> 						 struct acpi_rhct_node_hart_info *,
> 						 void *), void *data)
>=20
> > =C2=A0{
> > -	assert_msg(false, "ACPI not available");
> > +	u32 offset;
> > +	struct acpi_table_rhct *rhct;
> > +	struct acpi_rhct_node *node;
> > +	struct acpi_rhct_node_hart_info *hart_info;
>=20
> Need a blank line here. I'm thinking checkpatch wasn't run, since I'm sur=
e
> that would have been caught.
>=20
> Thanks,
> drew

